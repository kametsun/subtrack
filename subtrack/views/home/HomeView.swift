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

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            if viewModel.subscriptions.isEmpty {
                NavigationLink(
                    destination: SettingSubscriptionView(viewModel: appEnvironment.settingSubscriptionViewModel, isNewUser: false)
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
                                .foregroundColor(.white)
                                .listRowBackground(Color.darkGray)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("SubTrack")
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {isAdd = true}) {
                            Text("Add")
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.getSubscriptions()
        }
        .navigationDestination(isPresented: $isAdd) {
            SettingSubscriptionView(viewModel: appEnvironment.settingSubscriptionViewModel, isNewUser: false)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbarBackground(.background, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
    }

    var sectionHeader: some View {
        HStack {
            Text("Subscriptions").foregroundColor(.white)
        }
        .headerProminence(.increased)
    }
}

struct HomeViewPreview: PreviewProvider {
    static var previews: some View {
        let modelContainer = getSharedModelContainerPreview()
        let appEnvironment = AppEnvironment(
            modelContext: modelContainer.mainContext
        )
        let subscriptionRepository = SubscriptionRepository(
            modelContext: modelContainer.mainContext
        )
        let viewModel = HomeViewModel(
            subscriptionRepository: subscriptionRepository
        )
        createPreviewData(modelContext: modelContainer.mainContext)

        return HomeView(viewModel: viewModel)
            .environmentObject(appEnvironment)
            .modelContainer(modelContainer)
    }
}
