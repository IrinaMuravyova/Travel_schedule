//
//  StoriesView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 26.06.2026.
//

import SwiftUI

struct StoriesView: View {
    var body: some View {
        LazyHGrid(rows: [GridItem(.fixed(140))]) {
            ForEach(0..<5) { _ in RoundedRectangle(cornerRadius: 16) .fill(.blue) .frame(width: 92, height: 140)
            }
        }
        .frame(height: 188)
    }
}

#Preview {
    StoriesView()
}
