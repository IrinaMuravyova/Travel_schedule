//
//  FiltersView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 29.06.2026.
//

import SwiftUI

struct FiltersView: View {
    @Binding var selectedTimeSlots: Set<TimeSlot>
    @Binding var transferFilter: TransferFilter?
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var localSelectedTimeSlots: Set<TimeSlot> = []
    @State private var localShowTransfers: TransferFilter?
    
    private var isAnyFilterSelected: Bool {
        !localSelectedTimeSlots.isEmpty || localShowTransfers != nil
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                Text(NSLocalizedString("Departure time", comment: ""))
                    .font(.system(size: 24, weight: .bold))
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                
                VStack(spacing: 0) {
                    ForEach(TimeSlot.allCases, id: \.self) { interval in
                        TimeSlotRow(
                            time: interval.title,
                            isSelected: localSelectedTimeSlots.contains(interval),
                            action: {
                                if localSelectedTimeSlots.contains(interval) {
                                    localSelectedTimeSlots.remove(interval)
                                } else {
                                    localSelectedTimeSlots.insert(interval)
                                }
                            }
                        )
                    }
                }
                .padding(16)
                
                Text(NSLocalizedString("Show transfers", comment: ""))
                    .lineLimit(2)
                    .font(.system(size: 24, weight: .bold))
                    .padding(.horizontal, 16)
                
                VStack(spacing: 0) {
                    ForEach(TransferFilter.allCases, id: \.self) { option in
                        TransferRow(
                            title: option.title,
                            isSelected: localShowTransfers == option,
                            action: {
                                localShowTransfers = option
                            }
                        )
                    }
                }
                .background(colorScheme == .dark ? .black : Color.white)
                .cornerRadius(16)
                
                Spacer()
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    if isAnyFilterSelected {
                        Button(action: {
                            selectedTimeSlots = localSelectedTimeSlots
                            transferFilter = localShowTransfers
                            dismiss()
                        }) {
                            Text(NSLocalizedString("Apply", comment: ""))
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 343, height: 60)
                                .background(Color.blueUniversal)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal, 8)
                        .padding(.bottom, 20)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            localSelectedTimeSlots = selectedTimeSlots
            localShowTransfers = transferFilter
        }
    }
}
