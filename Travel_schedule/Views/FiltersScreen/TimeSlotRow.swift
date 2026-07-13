//
//  TimeSlotRow.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 06.07.2026.
//

import SwiftUI

struct TimeSlotRow: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let time: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(time)
                    .font(.system(size: 17))
                    .foregroundColor(colorScheme == .dark ? .white : .blackDay)
                    .tracking(-0.41)
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(colorScheme == .dark ? .white : .black, lineWidth: 2)
                        .frame(width: 20, height: 20)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(
                                    colorScheme == .dark
                                    ? (isSelected ? .white : .black)
                                    : (isSelected ? .black : .white)
                                )
                        )
                    
                    if isSelected {
                        Image(systemName: "checkmark")
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .font(.system(size: 12, weight: .bold))
                    }
                }
                .frame(width: 20, height: 20)
            }
            .contentShape(Rectangle())
            .frame(height: 60)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
