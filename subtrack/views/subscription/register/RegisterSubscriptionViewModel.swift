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
    @Published var cycle: Subscription.CycleType = .MONTH

    init(subscriptionRepository: SubscriptionRepository) {
        self.subscriptionRepository = subscriptionRepository
    }

    func setName(_ name: String) {
        self.name = name
    }

    func setCycle(_ cycle: Subscription.CycleType) {
        self.cycle = cycle
    }
}
