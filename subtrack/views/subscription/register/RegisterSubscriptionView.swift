//
//  RegisterSubscriptionView.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/20.
//

import SwiftUI

struct RegisterSubscriptionView: View {
    @ObservedObject var viewModel: RegisterSubscriptionViewModel

    init(viewModel: RegisterSubscriptionViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Text("Register Subscription")
    }
}
