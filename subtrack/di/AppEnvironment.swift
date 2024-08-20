//
//  AppEnvironment.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/19.
//

import Foundation
import SwiftData
import SwiftUI

class AppEnvironment: ObservableObject {
    @Published var registerUserViewModel: RegisterUserViewModel
    @Published var homeViewModel: HomeViewModel
    @Published var registerSubscriptionViewModel: RegisterSubscriptionViewModel

    init(modelContext: ModelContext) {
        let userRepository = UserRepository(modelContext: modelContext)
        let subscriptionRepository = SubscriptionRepository(modelContext: modelContext)

        self.registerUserViewModel = RegisterUserViewModel(
            userRepository: userRepository
        )
        self.homeViewModel = HomeViewModel(
            subscriptionRepository: subscriptionRepository
        )
        self.registerSubscriptionViewModel = RegisterSubscriptionViewModel(
            subscriptionRepository: subscriptionRepository
        )
    }
}
