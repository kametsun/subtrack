//
//  LaunchView.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/19.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var appEnvironment: AppEnvironment
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewMoel = LaunchViewModel()

    var body: some View {
        if viewMoel.isActive {
            switch viewMoel.viewState {
            case .registerUser:
                RegisterUserView(
                    viewModel: appEnvironment.registerUserViewModel
                )
            case .home:
                HomeView(
                    viewModel: appEnvironment.homeViewModel
                )
            }
        } else {
            ZStack {
                Color.primaryColor
                    .ignoresSafeArea()
                VStack {
                    Text("SubTrack")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(self.colorScheme == .dark ? Color.textColor : .white)
                }
            }
            .onAppear {
                viewMoel.startLaunchProcess()
            }
        }
    }
}
