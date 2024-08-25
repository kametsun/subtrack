//
//  SettingView.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/25.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var viewModel: SettingViewModel
    @State private var isLoading = true
    var userId: String?

    init(viewMode: SettingViewModel) {
        self.viewModel = viewMode
        self.userId = UserDefaults.standard.string(forKey: "userId")
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            if isLoading {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2.0)
                    Text("Loading...")
                        .foregroundStyle(.white)
                }
            } else if viewModel.user == nil {
                VStack {
                    Text("Error. User is not exists.")
                    Text("Please register your infomation")
                }
                .foregroundColor(.white)
            } else {
                VStack {
                    List {
                        Section(
                            header:
                                Text("Settings")
                                .foregroundColor(.white)
                                .headerProminence(.increased)
                        ) {
                            HStack {
                                Text("Version")
                                Spacer()
                                Text("1.0.0")
                            }
                            HStack {
                                Text("Name")
                                Spacer()
                                Text(viewModel.user!.name)
                            }
                            HStack {
                                Text("Notice")
                                Spacer()
                                Text(String(viewModel.user!.notifyBeforeDays) + "day ago")
                            }
                        }
                        .listRowBackground(Color.darkGray)
                    }
                    .foregroundColor(.white)
                }
                .scrollContentBackground(.hidden)
            }
        }
        .onAppear {
            loadUser()
        }

    }

    private func loadUser() {
        guard let userId = userId else { return }
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            viewModel.getUser(userId)
            isLoading = false
        }
    }
}
