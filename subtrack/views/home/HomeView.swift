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

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            if viewModel.subscriptions.isEmpty {
                NavigationLink(
                    destination: SettingSubscriptionView(viewModel: appEnvironment.settingSubscriptionViewModel)
                ) {
                    Text("Add Subscriptions")
                }
            } else {
                VStack {
                    List {
                        Section(header: SectionHeader) {
                            ForEach(viewModel.subscriptions) {subscription in
                                NavigationLink(
                                    destination: SettingSubscriptionView(
                                        viewModel: appEnvironment.settingSubscriptionViewModel, subscriptionId: subscription.id
                                    )
                                ) {
                                    Text(subscription.name)
                                        .font(.headline)
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
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.background, for: .navigationBar)
            }
        }
        .onAppear {
            viewModel.getSubscriptions()
        }
    }

    var SectionHeader: some View {
        HStack {
            Text("Subscriptions").foregroundColor(.white)
            Spacer()
            NavigationLink(
                destination: SettingSubscriptionView(viewModel: appEnvironment.settingSubscriptionViewModel)
            ) {
                Text("Add")
                    .foregroundColor(.white)
            }
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
