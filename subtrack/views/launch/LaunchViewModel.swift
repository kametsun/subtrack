//
//  LaunchViewModel.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/19.
//

import Foundation

class LaunchViewModel: ObservableObject {
    @Published
    var isActive = false

    func startLaunchProcess() {
        Task {
            try await Task.sleep(nanoseconds: 2_000_000_000)    // 2 sec
            DispatchQueue.main.async {
                self.isActive = true
            }
        }
    }
}
