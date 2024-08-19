//
//  RegisterUserView.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/19.
//

import SwiftUI
import SwiftData

struct RegisterUserView: View {
    @EnvironmentObject var appEnvironment: AppEnvironment
    var body: some View {
        VStack {
            switch appEnvironment.registerUserViewModel.viewState {
            case .EXISTS:
                Text("User alrready exists")
            case .SETTING_NAME:
                EnterNameView(viewModel: appEnvironment.registerUserViewModel)
            case .SETTING_NOTIFICATION:
                Text("Set up your notification preferences")
            }
        }
    }
}

struct EnterNameView: View {
    @ObservedObject var viewModel: RegisterUserViewModel
    @State private var name = ""
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("What's your name?")
                    .foregroundColor(.text)
                    .font(.title)
                
                CustomTextField(placeholder: "Enter your name", text: $name)
                
                CustomButton(label: "Next"){
                    viewModel.setName(name: name)
                }
            }
        }
    }
}
