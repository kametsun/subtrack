//
//  LaunchView.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/19.
//

import SwiftUI

struct LaunchView: View {
    @StateObject private var viewMoel = LaunchViewModel()
    
    var body: some View {
        if viewMoel.isActive {
            RegisterUserView()
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

#Preview {
    LaunchView()
}
