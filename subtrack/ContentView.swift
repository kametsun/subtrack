//
//  ContentView.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/18.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationStack {
            LaunchView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true)
}
