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

    @Published var errorMessage: String?
    @Published var isExists = false

    init(subscriptionRepository: SubscriptionRepository) {
        self.subscriptionRepository = subscriptionRepository
    }

    func settingSubscription(
        userId: String?,
        subscription: SettingSubscription
    ) -> Bool {
        guard let userId = userId else {
            setErrorMessage("User ID is nil")
            return false
        }
        checkSubscriptionExists(subscription.id)
        do {
            if isExists {
                try updateSubscription(userId: userId, subscription: subscription)
            } else {
                try registerSubscription(userId: userId, subscription: subscription)
            }
        } catch {
            setErrorMessage(error.localizedDescription)
            return false
        }

        return true
    }

    private func updateSubscription(userId: String, subscription: SettingSubscription) throws {
        let subscription = Subscription(
            id: subscription.id,
            userId: userId,
            name: subscription.name,
            url: subscription.url,
            cycle: subscription.cycle,
            price: subscription.price,
            startDate: subscription.startDate,
            status: subscription.status
        )
        try subscriptionRepository.updateSubscription(subscription)
    }

    private func registerSubscription(userId: String, subscription: SettingSubscription) throws {
        let id = "subscription_" + UUID().uuidString
        let subscription = Subscription(
            id: id,
            userId: userId,
            name: subscription.name,
            url: subscription.url,
            cycle: subscription.cycle,
            price: subscription.price,
            startDate: subscription.startDate,
            status: subscription.status
        )
        try subscriptionRepository.registerSubscription(subscription)
    }

    func checkSubscriptionExists(_ subscriptionId: String) {
        DispatchQueue.main.async {
            self.isExists = self.subscriptionRepository.getSubscriptionById(subscriptionId) != nil
        }
    }

    func getSubscriptionById(_ subscriptionId: String) -> SettingSubscription {
        let subscription = subscriptionRepository.getSubscriptionById(subscriptionId)
        checkSubscriptionExists(subscriptionId)
        return SettingSubscription(
            id: subscription?.id ?? "",
            name: subscription?.name ?? "",
            cycle: subscription?.cycle ?? .MONTH,
            price: subscription?.price ?? 0,
            url: subscription?.url ?? "",
            startDate: subscription?.startDate ?? Date(),
            status: subscription?.status ?? .ACTIVE
        )
    }

    private func setErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            self.errorMessage = message
        }
    }
}

struct SettingSubscription {
    var id: String
    var name: String
    var cycle: Subscription.CycleType
    var price: Int
    var url: String
    var startDate: Date
    var status: Subscription.StatusType
}
