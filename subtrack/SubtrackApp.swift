//
//  subtrackApp.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/18.
//

import SwiftUI
import SwiftData

@main
struct SubtrackApp: App {
    /**
     * 全体で共有されるModelContainerインスタンスの定義
     * 保存などの管理を行うコンテナ
     */
    var sharedModelContainer: ModelContainer = {
        /** データモデルのスキーマ定義 */
        let schema = Schema([
            User.self,
            Subscription.self
        ])
        /** 保存方法の定義 */
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            /** インスタンスを返す */
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    @StateObject private var appEnvironment: AppEnvironment

    init() {
        let modelContext = sharedModelContainer.mainContext
        _appEnvironment = StateObject(wrappedValue: AppEnvironment(modelContext: modelContext))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appEnvironment)
        }
        .modelContainer(sharedModelContainer)
    }
}
