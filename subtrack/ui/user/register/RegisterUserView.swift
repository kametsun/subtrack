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
                Text("Please enter your name")
            case .SETTING_NOTIFICATION:
                Text("Set up your notification preferences")
            }
        }
    }
}
