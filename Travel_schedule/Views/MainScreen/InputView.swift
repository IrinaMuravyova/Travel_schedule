//
//  InputView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 26.06.2026.
//

import SwiftUI

struct InputView: View {
    @Binding var direction: String
    var promt: String
    
    var body: some View {
        HStack {
            Text(direction.isEmpty ? promt : direction)
                .foregroundStyle(.grayUniversal)
                .font(.system(size: 17, weight: .regular))
                .tracking(-0.41)
            Spacer()
        }
        .padding()
        .frame(width: 259, height: 48)
        .contentShape(Rectangle())
    }
}
