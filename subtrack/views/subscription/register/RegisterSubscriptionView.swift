//
//  RegisterSubscriptionView.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/20.
//

import SwiftUI

struct RegisterSubscriptionView: View {
    @ObservedObject var viewModel: RegisterSubscriptionViewModel
    @State var name: String = ""
    @State var cycle: Subscription.CycleType = .MONTH
    @State var price: Int = 0
    @State var url: String = ""
    @State var startDate: Date = Date()
    @State var status: Subscription.StatusType = .ACTIVE

    init(viewModel: RegisterSubscriptionViewModel) {
        self.viewModel = viewModel
    }

    private func onAddClick() {
        let userId = UserDefaults.standard.string(forKey: "userId")
        if viewModel.registerSubscription(
            userId: userId!,
            name: name,
            cycle: cycle,
            price: price,
            url: url,
            statDate: startDate,
            status: status
        ) {
            print("register subscription is success")
        } else {
            print("register subscription is failed")
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
                            value: name,
                            title: "Name",
                            placeholder: "Enter name"
                        )
                        ListRow(
                            value: cycle,
                            title: "Cycle",
                            placeholder: cycle.rawValue
                        )
                        ListRow(
                            value: price,
                            title: "Price",
                            placeholder: "Enter price"
                        )
                        ListRow(
                            value: url,
                            title: "URL",
                            placeholder: "Enter url"
                        )
                        ListRow(
                            value: startDate,
                            title: "Start Date",
                            placeholder: formatDate(startDate)
                        )
                        ListRow(
                            value: status,
                            title: "Status",
                            placeholder: status.rawValue
                        )
                    }
                    .listRowBackground(Color.darkGray)
                }
            }.scrollContentBackground(.hidden)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(name.isEmpty ? "Register subscription" : name)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: onAddClick) {
                    Text("Add")
                        .foregroundColor(.white)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ListRow<T: Equatable & Hashable>: View {
    @State var value: T
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
