//
//  LaunchView.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/19.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var appEnvironment: AppEnvironment
    @StateObject private var viewMoel = LaunchViewModel()
    
    var body: some View {
        if viewMoel.isActive {
            RegisterUserView(viewModel: appEnvironment.registerUserViewModel)
        } else {
            VStack {
                Text("Launch")
                    .font(.largeTitle)
                    .padding()
            }
            .onAppear {
                viewMoel.startLaunchProcess()
            }
        }
    }
}

struct HomeView: View {
    var body: some View {
        Text("Home")
            .font(.largeTitle)
            .padding()
    }
}
