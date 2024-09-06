//
//  CustomButton.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/19.
//

import SwiftUI

struct CustomButton: View {
    var label: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .foregroundColor(.textColor)
                .fontWeight(.bold)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(.background)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
