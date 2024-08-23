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
class SettingSubscriptionViewModel: ObservableObject {
    private var subscriptionRepository: SubscriptionRepository

    @Published var errorMessage = ""

    init(subscriptionRepository: SubscriptionRepository) {
        self.subscriptionRepository = subscriptionRepository
    }

    func registerSubscription(
        userId: String?,
        subscription: SettingSubscription
    ) -> Bool {
        if userId == nil {
            return false
        } else {
            let id = "subscription_" + UUID().uuidString
            let subscription = Subscription(
                id: id,
                userId: userId!,
                name: subscription.name,
                url: subscription.url,
                cycle: subscription.cycle,
                price: subscription.price,
                startDate: subscription.startDate,
                status: subscription.status
            )
            do {
                try subscriptionRepository.registerSubscription(subscription)
            } catch {
                errorMessage = "Failed to register subscription"
                return false
            }
        }
        return true
    }
}

struct SettingSubscription {
    let name: String
    let cycle: Subscription.CycleType
    let price: Int
    let url: String
    let startDate: Date
    let status: Subscription.StatusType
}
