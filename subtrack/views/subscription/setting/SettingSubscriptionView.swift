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
                currency: subscription.currency,
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
            Color.primaryColor
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
                            value: $subscription.currency,
                            title: "Currency",
                            placeholder: subscription.currency.rawValue
                        )
                        ListRow(
                            value: $subscription.price,
                            title: "Price",
                            placeholder: "Enter price",
                            currencyType: subscription.currency
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
                    .listRowBackground(Color.secondaryColor)
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
    var currencyType: CurrencyType?

    var body: some View {
        NavigationLink(destination: EditView(value: $value, title: title)) {
            HStack {
                Text(title)
                if let stringValue = value as? String, title == "URL" {
                    if let faviconURL = getFaviconURL(url: stringValue) {
                        AsyncImage(url: faviconURL) { phase in
                            if let image = phase.image {
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 28, height: 28)
                            } else if phase.error != nil {
                                Image(systemName: "questionmark.app")
                            } else {
                                ProgressView()
                            }
                        }
                    }
                }
                Spacer()
                if let cycleType = value as? Subscription.CycleType {
                    Text(cycleType.rawValue)
                } else if let statusType = value as? Subscription.StatusType {
                    Text(statusType.rawValue)
                } else if let currencyType = value as? CurrencyType {
                    Text(currencyType.rawValue)
                } else if let stringValue = value as? String {
                    Text(stringValue.isEmpty ? placeholder : stringValue)
                } else if let intValue = value as? Int {
                    Text(String(intValue))
                } else if let doubleValue = value as? Double {
                    if currencyType != nil {
                        Image(systemName: CurrencyType.currencyIcon(for: currencyType!))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.textColor)
                    }
                    Text(String(doubleValue))
                } else if let dateValue = value as? Date {
                    Text(formatDate(dateValue))
                }
            }
            .foregroundColor(.textColor)
        }
    }
}

struct EditView<T: Equatable & Hashable>: View {
    @Binding var value: T
    let title: String

    var body: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea()

            VStack {
                if value as? Subscription.CycleType != nil {
                    Picker(title, selection: $value) {
                        ForEach(Subscription.CycleType.allCases, id: \.self) { cycle in
                            Text(cycle.rawValue)
                                .tag(cycle)
                                .foregroundColor(Color.textColor)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding()
                } else if value as? Subscription.StatusType != nil {
                    Picker(title, selection: $value) {
                        ForEach(Subscription.StatusType.allCases, id: \.self) { status in
                            Text(status.rawValue)
                                .tag(status)
                                .foregroundColor(Color.textColor)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding()
                } else if value as? CurrencyType != nil {
                    Picker(title, selection: $value) {
                        ForEach(CurrencyType.allCases, id: \.self) { currency in
                            Text(currency.rawValue)
                                .tag(currency)
                                .foregroundColor(Color.textColor)
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
                    .background(Color.secondaryColor)
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
                    .background(Color.secondaryColor)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.clear, lineWidth: 0)
                    }
                    Spacer()
                } else if value is Double {
                    TextField(title, text: Binding(
                        get: {
                            if let doubleValue = value as? Double {
                                return String(doubleValue)
                            } else {
                                return ""
                            }
                        },
                        set: { newValue in
                            if let intValue = Double(newValue), let typedValue = intValue as? T {
                                value = typedValue
                            }
                        }
                    ))
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.secondaryColor)
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
                    .accentColor(Color.textColor)
                    .padding()
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .foregroundStyle(Color.textColor)
                        .fontWeight(.bold)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
