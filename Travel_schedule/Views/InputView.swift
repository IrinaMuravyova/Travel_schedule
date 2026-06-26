//
//  InputView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 26.06.2026.
//

import SwiftUI

struct InputView: View {
    @State var direction: String = ""
    var promt: String
    
    var body: some View {
        TextField(
            direction,
            text: $direction,
            prompt:
                Text(promt)
                .foregroundStyle(.grayUniversal)
                .font(.system(size: 17, weight: .regular))
                .tracking(-0.41)
        )
        .padding()
        .frame(width: 259, height: 48)
    }
}

#Preview {
    InputView(promt: "Введите направление")
}
