//
//  RegisterUserViewModel.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/19.
//

import Foundation
import Combine

/**
 * ユーザ登録画面の状態を管理するViewModel
 */
class RegisterUserViewModel: ObservableObject {
    enum ViewState: String, Codable {
        case exist
        case settingName
        case settingNotification
    }

    @Published var errorMessage = ""
    @Published var viewState: ViewState = .settingName

    private var userRepository: UserRepository
    private var name = ""
    private var notifyBeforeDays = 0

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        checkUserExistence()
    }

    func setName(_ name: String) {
        self.name = name
        viewState = .settingNotification
    }

    func setNotifyBeforeDays(_ day: Int) {
        self.notifyBeforeDays = day
        viewState = .exist
    }

    func registerUser() {
        do {
            let id = "user_" + UUID().uuidString
            let user = User(
                id: id,
                name: name,
                notifyBeforeDays: notifyBeforeDays,
                createdAt: Date(),
                updatedAt: Date(),
                subscriptions: [Subscription]()
            )
            try userRepository.registerUser(user: user)
            name = ""
            notifyBeforeDays = 0
        } catch {
            errorMessage = "Failed to create user"
        }
    }

    private func checkUserExistence() {
        do {
            if try userRepository.getUser() != nil {
                self.viewState = .exist
            } else {
                self.viewState = .settingName
            }
        } catch {
            errorMessage = "failed"
            self.viewState = .settingName
        }
    }
}
