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
                    destination: RegisterSubscriptionView(viewModel: appEnvironment.registerSubscriptionViewModel)
                ) {
                    Text("Add Subscriptions")
                }
            } else {
                List(viewModel.subscriptions) { subscription in
                    VStack(alignment: .leading) {
                        Text(subscription.name)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(subscription.url)
                            .font(.headline)
                    }
                    .listRowBackground(Color.darkGray)
                }
                .scrollContentBackground(.hidden)
            }
        }
        .onAppear {
            viewModel.getSubscriptions()
        }
    }
}
