//
//  PreviewUtils.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/24.
//

import Foundation
import SwiftData

func getSharedModelContainerPreview() -> ModelContainer {
    let sharedModelContainerPreview: ModelContainer = {
        /** データモデルのスキーマ定義 */
        let schema = Schema([
            User.self,
            Subscription.self
        ])
        /** 保存方法の定義 */
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            /** インスタンスを返す */
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    return sharedModelContainerPreview
}

func createPreviewData(modelContext: ModelContext) {
    let userRepository = UserRepository(modelContext: modelContext)
    let subscriptionRepository = SubscriptionRepository(modelContext: modelContext)
    do {
        try userRepository.registerUser(
            user: User(
                id: "user_1",
                name: "test",
                notifyBeforeDays: 1,
                createdAt: Date(),
                updatedAt: Date(),
                subscriptions: []
            )
        )
        try subscriptionRepository.registerSubscription(
            Subscription(
                id: "subscription_1",
                userId: "user_1",
                name: "Apple Music",
                url: "",
                cycle: .MONTH,
                currency: .USD,
                price: 980,
                startDate: Date(),
                status: .ACTIVE
            )
        )
    } catch {
        print("failed create test data")
    }

}
