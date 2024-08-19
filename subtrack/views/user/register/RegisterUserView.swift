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
    @State var name = ""
    @State var strNotifyBeforeDays = ""

    init(viewModel: RegisterUserViewModel) {
        self.viewModel = viewModel
        viewModel.checkUserExistence()
    }

    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .exist:
                userExistView
            case .settingName:
                enterNameView
            case .settingNotification:
                enterNotifyBeforeDays
            }
        }
    }

    var userExistView: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Set up your first subscription!")
                    .foregroundColor(.text)
                    .font(.title)

                CustomButton(label: "OK") {
                    viewModel.registerUser()
                }
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

                CustomButton(label: "Next") {
                    viewModel.setName(name)
                }
            }
        }
    }

    var enterNotifyBeforeDays: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("How many days' notice do you want?")
                    .foregroundColor(.text)
                    .font(.title)

                CustomTextField(placeholder: "Enter notify before days", text: $strNotifyBeforeDays, isNumeric: true)
                CustomButton(label: "Next") {
                    viewModel.setNotifyBeforeDays(Int(strNotifyBeforeDays)!)
                }
            }
        }
    }

    private func validateAndProceed() {
        guard let days = Int(strNotifyBeforeDays) else {
            viewModel.errorMessage = "Please enter number"
            return
        }

        if days < 1 || days > 7 {
            viewModel.errorMessage = "Please enter 1~7"
        } else {
            viewModel.errorMessage = ""
            viewModel.setNotifyBeforeDays(days)
        }
    }
}
