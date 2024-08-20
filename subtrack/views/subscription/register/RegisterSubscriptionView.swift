//
//  RegisterSubscriptionView.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/20.
//

import SwiftUI

struct RegisterSubscriptionView: View {
    @ObservedObject var viewModel: RegisterSubscriptionViewModel
    @State private var name = ""

    init(viewModel: RegisterSubscriptionViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            Form {
                Section {
                    List {
                        NavigationLink(destination: EditView(value: $name, title: "Name")) {
                            HStack {
                                Text("Name")
                                    .foregroundStyle(.black)
                                Spacer()
                                Text(viewModel.name.isEmpty ? "Enter name" : viewModel.name)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
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

struct EditView: View {
    @Binding var value: String
    let title: String

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            VStack {
                TextField(title, text: $value)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.clear, lineWidth: 0)
                    )
                Spacer()
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
