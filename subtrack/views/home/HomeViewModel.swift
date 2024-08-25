//
//  HomeViewModel.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/20.
//

import Foundation

/**
 * ホーム画面の状態を管理するViewModel
 */
class HomeViewModel: ObservableObject {
    @Published var subscriptions: [Subscription] = []
    @Published var user: User?
    private var subscriptionRepository: SubscriptionRepository
    private var userRepository: UserRepository

    init(subscriptionRepository: SubscriptionRepository, userRepository: UserRepository) {
        self.subscriptionRepository = subscriptionRepository
        self.userRepository = userRepository
        loadData()
    }

    func loadData() {
        DispatchQueue.main.async {
            self.getUserAndSubscriptions()
        }
    }

    private func getUserAndSubscriptions() {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else { return }
        do {
            self.user = try self.userRepository.getUser(userId: userId)
            self.subscriptions = self.subscriptionRepository.getSubscriptions(for: userId)
        } catch {
            print("Failed to get user or subscriptions: \(error.localizedDescription)")
        }
    }

    func scheduleAllNotifications() {
        guard let user = user else {
            print("User is not loaded.")
            return
        }
        for subscription in self.subscriptions where subscription.status == .ACTIVE {
            scheduleNotification(for: subscription, user: user)
        }
    }
}
