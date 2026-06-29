//
//  ErrorView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 29.06.2026.
//

import SwiftUI

struct ErrorView: View {
    var image: ImageResource
    var text: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Image(image)
                .resizable()
                .frame(width: 223, height: 223)
                .cornerRadius(70)
            Text(text)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.blackDay)
        }
    }
}

#Preview {
    ErrorView(image: .noInternet, text: "No internet")
}
