//
//  LaunchViewModel.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/19.
//

import Foundation

class LaunchViewModel: ObservableObject {
    enum ViewState: String, Codable {
        case registerUser
        case home
    }

    @Published var isActive = false
    @Published var viewState: ViewState = .registerUser

    func startLaunchProcess() {
        Task {
            if UserDefaults.standard.string(forKey: "userId") != nil {
                self.viewState = .home
            } else {
                self.viewState = .registerUser
            }

            try await Task.sleep(nanoseconds: 1_000_000_000)
            DispatchQueue.main.async {
                self.isActive = true
            }
        }
    }
}
