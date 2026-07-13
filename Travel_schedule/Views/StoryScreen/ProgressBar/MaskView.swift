//
//  MaskView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 13.07.2026.
//

import SwiftUI

struct MaskView: View {
    let numberOfSections: Int
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0 ..< numberOfSections, id: \.self) { _ in
                MaskFragmentView()
            }
        }
    }
}

#Preview {
    MaskView(numberOfSections: 3)
}
