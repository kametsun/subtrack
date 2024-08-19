//
//  RegisterUserView.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/19.
//

import SwiftUI
import SwiftData

struct RegisterUserView: View {
    @ObservedObject var viewModel: RegisterUserViewModel
    @State var name: String = ""
    
    init(viewModel: RegisterUserViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("ステート: \(viewModel.viewState)")
        VStack {
            switch viewModel.viewState {
            case .EXISTS:
                Text("User alrready exists")
            case .SETTING_NAME:
                enterNameView
            case .SETTING_NOTIFICATION:
                Text("Set up your notification preferences")
            }
        }
    }
    
    var enterNameView: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("What's your name?")
                    .foregroundColor(.text)
                    .font(.title)
                
                CustomTextField(placeholder: "Enter your name", text: $name)
                
                CustomButton(label: "Next"){
                    viewModel.setName(name)
                }
            }
        }
    }
}
