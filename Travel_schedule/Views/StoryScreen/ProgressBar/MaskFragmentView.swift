//
//  MaskFragmentView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 13.07.2026.
//

import SwiftUI

struct MaskFragmentView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 3)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundStyle(.white)
            .frame(height: 6)
    }
}

#Preview {
    MaskFragmentView()
}
