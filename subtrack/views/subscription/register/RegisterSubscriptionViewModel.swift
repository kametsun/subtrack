//
//  RegisterSubscriptionViewModel.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/20.
//

import Foundation

/**
 * サブスクリプション登録画面の状態を管理するViewModel
 */
class RegisterSubscriptionViewModel: ObservableObject {
    private var subscriptionRepository: SubscriptionRepository
    @Published var name: String = ""

    init(subscriptionRepository: SubscriptionRepository) {
        self.subscriptionRepository = subscriptionRepository
    }
}
