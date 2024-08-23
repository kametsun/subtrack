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
    private var subscriptionRepository: SubscriptionRepository

    init(subscriptionRepository: SubscriptionRepository) {
        self.subscriptionRepository = subscriptionRepository
        getSubscriptions()
    }

    func getSubscriptions() {
        DispatchQueue.main.async {
            let userId = UserDefaults.standard.string(forKey: "userId")
            if userId != nil {
                self.subscriptions = self.subscriptionRepository.getSubscriptions(
                    for: userId!
                )
            }
        }
    }
}
