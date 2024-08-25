//
//  RegisterSubscriptionView.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/20.
//

import SwiftUI

struct SettingSubscriptionView: View {
    @EnvironmentObject var appEnvironment: AppEnvironment
    @ObservedObject var viewModel: SettingSubscriptionViewModel
    @State var subscription: SettingSubscription
    @State private var isNewUser: Bool
    @State private var isNavigateToHome = false

    init(viewModel: SettingSubscriptionViewModel, subscriptionId: String = "", isNewUser: Bool) {
        self.viewModel = viewModel
        self.subscription = viewModel.getSubscriptionById(subscriptionId)
        self.isNewUser = isNewUser
    }

    private func onAddClick() {
        let userId = UserDefaults.standard.string(forKey: "userId")
        if viewModel.settingSubscription(
            userId: userId!,
            subscription: SettingSubscription(
                id: subscription.id,
                name: subscription.name,
                cycle: subscription.cycle,
                price: subscription.price,
                url: subscription.url,
                startDate: subscription.startDate,
                status: subscription.status
            )
        ) {
            isNavigateToHome = true
        } else {
            isNavigateToHome = false
        }
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            Form {
                Section {
                    List {
                        ListRow(
                            value: $subscription.name,
                            title: "Name",
                            placeholder: "Enter name"
                        )
                        ListRow(
                            value: $subscription.cycle,
                            title: "Cycle",
                            placeholder: subscription.cycle.rawValue
                        )
                        ListRow(
                            value: $subscription.price,
                            title: "Price",
                            placeholder: "Enter price"
                        )
                        ListRow(
                            value: $subscription.url,
                            title: "URL",
                            placeholder: "Enter url"
                        )
                        ListRow(
                            value: $subscription.startDate,
                            title: "Start Date",
                            placeholder: formatDate(subscription.startDate)
                        )
                        ListRow(
                            value: $subscription.status,
                            title: "Status",
                            placeholder: subscription.status.rawValue
                        )
                    }
                    .listRowBackground(Color.darkGray)
                }
            }.scrollContentBackground(.hidden)
        }
        .onAppear {
            viewModel.checkSubscriptionExists(subscription.id)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(subscription.name.isEmpty ? "Register subscription" : subscription.name)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: onAddClick) {
                    Text(viewModel.isExists ? "Update" : "Add")
                        .foregroundColor(.white)
                }
            }
        }
        .navigationBarBackButtonHidden(isNewUser ? true : false)
        .toolbarBackground(.hidden, for: .navigationBar)
        .navigationDestination(isPresented: $isNavigateToHome) {
            HomeView(viewModel: appEnvironment.homeViewModel)
        }
    }
}

struct ListRow<T: Equatable & Hashable>: View {
    @Binding var value: T
    var title: String
    var placeholder: String

    var body: some View {
        NavigationLink(destination: EditView(value: $value, title: title)) {
            HStack {
                Text(title)
                    .foregroundStyle(.white)
                Spacer()
                if let cycleType = value as? Subscription.CycleType {
                    Text(cycleType.rawValue)
                        .foregroundColor(.white)
                } else if let statusType = value as? Subscription.StatusType {
                    Text(statusType.rawValue)
                        .foregroundColor(.white)
                } else if let stringValue = value as? String {
                    Text(stringValue.isEmpty ? placeholder : stringValue)
                        .foregroundColor(.white)
                } else if let intValue = value as? Int {
                    Text(String(intValue))
                        .foregroundColor(.white)
                } else if let dateValue = value as? Date {
                    Text(formatDate(dateValue))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct EditView<T: Equatable & Hashable>: View {
    @Binding var value: T
    let title: String

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack {
                if value as? Subscription.CycleType != nil {
                    Picker(title, selection: $value) {
                        ForEach(Subscription.CycleType.allCases, id: \.self) { cycle in
                            Text(cycle.rawValue)
                                .tag(cycle)
                                .foregroundColor(.white)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding()
                } else if value as? Subscription.StatusType != nil {
                    Picker(title, selection: $value) {
                        ForEach(Subscription.StatusType.allCases, id: \.self) { status in
                            Text(status.rawValue)
                                .tag(status)
                                .foregroundColor(.white)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding()
                } else if let stringValue = value as? String {
                    TextField(title, text: Binding(
                        get: { stringValue},
                        set: { newValue in
                            if let typedValue = newValue as? T {
                                value = typedValue
                            }
                        }
                    ))
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.clear, lineWidth: 0)
                    )
                    Spacer()
                } else if value is Int {
                    TextField(title, text: Binding(
                        get: {"\(value as? Int ?? 0)"},
                        set: { newValue in
                            if let intValue = Int(newValue), let typedValue = intValue as? T {
                                value = typedValue
                            }
                        }
                    ))
                    .keyboardType(.numberPad)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.clear, lineWidth: 0)
                    }
                    Spacer()
                } else if value is Date {
                    DatePicker(title, selection: Binding(
                        get: {
                            if let dateValue = value as? Date {
                                return dateValue
                            } else {
                                return Date()
                            }
                        }, set: { newDate in
                            if let typedValue = newDate as? T {
                                value = typedValue
                            }
                        }
                    ), displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .accentColor(.white)
                    .colorScheme(.dark)
                    .padding()
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
