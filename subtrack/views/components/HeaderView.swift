//
//  HeaderView.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/23.
//

import SwiftUI

struct HeaderView: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .background(.black)
    }
}

#Preview {
    HeaderView(title: "SubTrack")
}
