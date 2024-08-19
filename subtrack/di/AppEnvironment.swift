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
    @Published
    var registerUserViewModel: RegisterUserViewModel

    init(modelContext: ModelContext) {
        self.registerUserViewModel = RegisterUserViewModel(
            userRepository: UserRepository(modelContext: modelContext)
        )
    }
}
