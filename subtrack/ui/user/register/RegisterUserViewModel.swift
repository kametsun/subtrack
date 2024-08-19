//
//  RegisterUserViewModel.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/19.
//

import Foundation

/**
 * ユーザ登録画面の状態を管理するViewModel
 */
class RegisterUserViewModel: ObservableObject {
    enum ViewState: String, Codable {
        case EXISTS
        case SETTING_NAME
        case SETTING_NOTIFICATION
    }
    
    @Published var errorMessage = ""
    @Published var viewState: ViewState = .SETTING_NAME
    
    private var userRepository: UserRepository
    private var name = ""
    private var notifyBeforeDays = 0
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        checkUserExistence()
    }
    
    func setName(name: String){
        self.name = name
    }
    
    func setNotifyBeforeDays(day: Int){
        self.notifyBeforeDays = day
    }
    
    func registerUser(){
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
            if let _ = try userRepository.getUser() {
                self.viewState = .EXISTS
            } else {
                self.viewState = .SETTING_NAME
            }
        } catch {
            errorMessage = "failed"
            self.viewState = .SETTING_NAME
        }
    }
}
