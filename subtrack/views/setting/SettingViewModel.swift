//
//  SettingViewModel.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/25.
//

import Foundation

/**
 * 設定画面の状態を管理するViewModel
 */
class SettingViewModel: ObservableObject {
    private var userRepository: UserRepository
    @Published var user: User?

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func getUser(_ userId: String) {
        do {
            try self.user = userRepository.getUser(userId: userId)
        } catch {
            print("Failed get user")
        }
    }
}
