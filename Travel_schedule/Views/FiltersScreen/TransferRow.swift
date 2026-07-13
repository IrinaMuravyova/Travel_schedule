//
//  TransferRow.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 06.07.2026.
//

import SwiftUI

struct TransferRow: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    private let borderWidth: CGFloat = 2
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 17))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(colorScheme == .dark ? .white : Color.blackDay, lineWidth: borderWidth)
                        .frame(width: 20 + borderWidth, height: 20)
                        .background(
                            Circle()
                                .fill(colorScheme == .dark ? .black : .white)
                        )
                    
                    if isSelected {
                        Circle()
                            .fill(colorScheme == .dark ? .white : .blackDay)
                            .frame(width: 12, height: 12)
                    }
                }
                .frame(width: 20, height: 20)
            }
            .contentShape(Rectangle())
            .padding(.horizontal, 16)
        }
        .frame(height: 60)
        .buttonStyle(PlainButtonStyle())
    }
}
