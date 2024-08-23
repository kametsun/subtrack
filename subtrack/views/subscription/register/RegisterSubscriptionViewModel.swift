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

    @Published var errorMessage = ""

    init(subscriptionRepository: SubscriptionRepository) {
        self.subscriptionRepository = subscriptionRepository
    }

    func registerSubscription(
        userId: String?,
        name: String,
        cycle: Subscription.CycleType,
        price: Int,
        url: String,
        statDate: Date,
        status: Subscription.StatusType
    ) -> Bool {
        if userId == nil {
            return false
        } else {
            let id = "subscription_" + UUID().uuidString
            let subscription = Subscription(
                id: id,
                userId: userId!,
                name: name,
                url: url,
                cycle: cycle,
                price: price,
                startDate: statDate,
                status: status
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
