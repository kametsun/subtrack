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

    init(viewModel: RegisterSubscriptionViewModel) {
        self.viewModel = viewModel
        name = viewModel.name
        cycle = viewModel.cycle
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
                            placeholder: "Enter name",
                            onSelect: viewModel.setName
                        )
                        ListRow(
                            value: cycle,
                            title: "Cycle",
                            placeholder: viewModel.cycle.rawValue,
                            onSelect: viewModel.setCycle
                        )
                    }
                    .listRowBackground(Color.darkGray)
                }
            }.scrollContentBackground(.hidden)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.name.isEmpty ? "Register subscription" : viewModel.name)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ListRow<T: Equatable & Hashable>: View {
    @State var value: T
    var title: String
    var placeholder: String
    var onSelect: (T) -> Void

    var body: some View {
        NavigationLink(destination: EditView(value: $value, title: title)) {
            HStack {
                Text(title)
                    .foregroundStyle(.white)
                Spacer()
                if let cycleType = value as? Subscription.CycleType {
                    Text(cycleType.rawValue)
                        .foregroundColor(.white)
                } else if let stringValue = value as? String {
                    Text(stringValue.isEmpty ? placeholder : stringValue)
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
