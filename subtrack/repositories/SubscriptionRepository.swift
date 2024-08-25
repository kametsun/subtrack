//
//  SubscriptionRepository.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/20.
//

import Foundation
import SwiftData

class SubscriptionRepository {
    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func getSubscriptions(for userId: String) -> [Subscription] {
        let fetchDescriptor = FetchDescriptor<Subscription>(
            predicate: #Predicate { $0.userId == userId }
        )
        do {
            let subscriptions = try modelContext.fetch(fetchDescriptor)
            return subscriptions
        } catch {
            return []
        }
    }

    func getSubscriptionById(_ subscriptionId: String) -> Subscription? {
        let fetchDescriptor = FetchDescriptor<Subscription>(
            predicate: #Predicate {
                $0.id == subscriptionId
            }
        )
        do {
            let subscriptions = try modelContext.fetch(fetchDescriptor)
            return subscriptions.first
        } catch {
            return nil
        }
    }

    func registerSubscription(_ subscription: Subscription) throws {
        modelContext.insert(subscription)
        try modelContext.save()
    }

    func updateSubscription(_ subscription: Subscription) throws {
        modelContext.insert(subscription)
        try modelContext.save()
    }
}
