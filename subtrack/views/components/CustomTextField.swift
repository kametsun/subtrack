//
//  CustomTextField.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/19.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isNumeric = false

    var body: some View {
        VStack {
            TextField(placeholder, text: $text)
                .keyboardType(isNumeric ? .numberPad : .default)
                .onChange(of: text) {
                    if isNumeric {
                        text = text.filter { "0123456789".contains($0) }
                    }
                }
                .padding(.vertical, 2)
                .padding(.horizontal, 40)
                .background(Color.primaryColor)
                .foregroundColor(Color.text)
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.white)
                .padding(.horizontal, 40)
        }
    }
}
