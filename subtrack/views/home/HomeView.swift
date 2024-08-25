//
//  HomeView.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/20.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appEnvironment: AppEnvironment
    @ObservedObject var viewModel: HomeViewModel
    @State private var isAdd: Bool = false
    @State private var isSetting: Bool = false

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea()

            if viewModel.subscriptions.isEmpty {
                NavigationLink(
                    destination: SettingSubscriptionView(
                        viewModel: appEnvironment.settingSubscriptionViewModel, isNewUser: false
                    )
                ) {
                    Text("Add Subscriptions")
                }
            } else {
                VStack {
                    List {
                        Section(header: sectionHeader) {
                            ForEach(viewModel.subscriptions) {subscription in
                                NavigationLink(
                                    destination: SettingSubscriptionView(
                                        viewModel: appEnvironment.settingSubscriptionViewModel,
                                        subscriptionId: subscription.id,
                                        isNewUser: false
                                    )
                                ) {
                                    HStack {
                                        Text(subscription.name)
                                            .font(.headline)
                                        Spacer()
                                        Text(String(subscription.price))
                                    }
                                }
                                .foregroundColor(.textColor)
                                .listRowBackground(Color.secondaryColor)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: setIsSetting) {
                            Image(systemName: "gear")
                                .foregroundColor(.white)
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("SubTrack")
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: setIsAdd) {
                            Text("Add")
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadData()
            requestNotificationAuthorization()
            viewModel.scheduleAllNotifications()
        }
        .navigationDestination(isPresented: $isAdd) {
            SettingSubscriptionView(viewModel: appEnvironment.settingSubscriptionViewModel, isNewUser: false)
        }
        .navigationDestination(isPresented: $isSetting) {
            SettingView(
                viewMode: appEnvironment.settingViewModel
            )
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbarBackground(.background, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
    }

    var sectionHeader: some View {
        Text("Subscriptions").foregroundColor(.white)
            .headerProminence(.increased)
    }

    func setIsAdd() {
        self.isAdd = true
    }

    func setIsSetting() {
        self.isSetting = true
    }

    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification access granted.")
            } else if let error = error {
                print("Notification access denied.")
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
