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
    @Published var isActive: Bool = false
    @Published var viewState: ViewState = .registerUser

    func startLaunchProcess() {
        let state: ViewState = UserDefaults.standard.string(forKey: "userId") != nil ? .home : .registerUser
        Task {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            DispatchQueue.main.async {
                self.viewState = state
                self.isActive = true
            }
        }
    }
}
