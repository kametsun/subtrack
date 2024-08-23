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
