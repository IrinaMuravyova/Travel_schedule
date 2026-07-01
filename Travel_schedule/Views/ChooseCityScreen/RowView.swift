//
//  RowView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 29.06.2026.
//

import SwiftUI

struct RowView: View {
    var direction: String
    
    var body: some View {
        HStack {
            Text(direction)
                .font(.system(size: 17, weight: .regular))
                .tracking(-0.41)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
            
            Image(.chevron)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24, alignment: .center)
                .padding(.trailing, 16)
                .foregroundStyle(.blackDay)
        }
        .frame(height: 60)
        .foregroundStyle(.blackDay)
    }
}
