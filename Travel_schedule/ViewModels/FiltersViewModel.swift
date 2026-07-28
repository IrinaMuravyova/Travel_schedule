//
//  FiltersViewModel.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 28.07.2026.
//

import Foundation
import Combine

@MainActor
final class FiltersViewModel: ObservableObject {
    @Published var selectedTimeSlots: Set<TimeSlot>
    @Published var transferFilter: TransferFilter?
    
    init(
        selectedTimeSlots: Set<TimeSlot> = [],
        transferFilter: TransferFilter? = nil
    ) {
        self.selectedTimeSlots = selectedTimeSlots
        self.transferFilter = transferFilter
    }
    
    var isAnyFilterSelected: Bool {
        !selectedTimeSlots.isEmpty || transferFilter != nil
    }
    
    func toggleTimeSlot(_ slot: TimeSlot) {
        if selectedTimeSlots.contains(slot) {
            selectedTimeSlots.remove(slot)
        } else {
            selectedTimeSlots.insert(slot)
        }
    }
    
    func selectTransferFilter(_ filter: TransferFilter) {
        transferFilter = filter
    }
    
    func clearFilters() {
        selectedTimeSlots.removeAll()
        transferFilter = nil
    }
}
