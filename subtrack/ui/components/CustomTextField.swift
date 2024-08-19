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
    
    var body: some View {
        VStack {
            TextField(placeholder, text: $text)
                .padding(.vertical, 2)
                .padding(.horizontal, 40)
                .background(Color.background)
                .foregroundColor(Color.text)
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.white)
                .padding(.horizontal, 40)
        }
    }
}
