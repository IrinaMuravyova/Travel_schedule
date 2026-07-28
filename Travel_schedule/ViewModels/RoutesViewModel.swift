//
//  RoutesViewModel.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 02.07.2026.
//

import SwiftUI
import Combine

@MainActor
final class RoutesViewModel: ObservableObject {
    // MARK: - Properties
    @Published var from: String = ""
    @Published var to: String = ""
    
    @Published var fromStation: Components.Schemas.Station?
    @Published var toStation: Components.Schemas.Station?
    
    @Published var fromSettlement: Components.Schemas.Settlement?
    @Published var toSettlement: Components.Schemas.Settlement?
    
    @Published var fromCode: String = ""
    @Published var toCode: String = ""
    
    @Published var isSearching: Bool = false
    @Published var showCarriersList: Bool = false
    
    @Published var selectedTimeSlots: Set<TimeSlot> = []
    @Published var transferFilter: TransferFilter?
    
    private let pageSize = 10
    private var offset = 0
    
    @Published var isLoadingMore = false
    private var hasMore = true
    
    private var allSegments: [Components.Schemas.Segment] = []
    
    var displayedSegments: [Components.Schemas.Segment] {
        allSegments.filter { segment in
            var matchesTime = true
            var matchesTransfer = true
            
            if !selectedTimeSlots.isEmpty, let departure = segment.departure {
                matchesTime = selectedTimeSlots.contains { slot in
                    isTimeInRange(time: departure, timeSlot: slot)
                }
            }
            
            if let transferFilter = transferFilter {
                switch transferFilter {
                case .withTransfers:
                    matchesTransfer = segment.has_transfers == true
                case .withoutTransfers:
                    matchesTransfer = segment.has_transfers == false
                }
            }
            
            return matchesTime && matchesTransfer
        }
    }
    
    var hasFilteredResults: Bool {
        !displayedSegments.isEmpty
    }
    
    var hasMorePages: Bool {
        hasMore
    }
    
    private let routesBetweenStationsLoader: RoutesBetweenStationsLoader
    
    // MARK: - Init
    init (routesBetweenStationsLoader: RoutesBetweenStationsLoader) {
        self.routesBetweenStationsLoader = routesBetweenStationsLoader
    }
    
    // MARK: - Functions
    func searchRoutes() {
        guard !fromCode.isEmpty, !toCode.isEmpty else { return }
        
        offset = 0
        hasMore = true
        
        isSearching = true
        
        Task {
            await loadRoutes(reset: true)
        }
    }
    
    func loadMore() {
        guard !isLoadingMore, hasMore else { return }
        
        isLoadingMore = true
        offset += pageSize
        
        Task {
            await loadRoutes(reset: false)
        }
    }
    
    func checkNeedMoreLoading() {
        if displayedSegments.count < 3 && hasMorePages {
            loadMore()
        }
    }
}

// MARK: - Private functions
extension RoutesViewModel {
    private func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: Date())
    }
    
    private func loadRoutes(reset: Bool) async {
        do {
            let result = try await routesBetweenStationsLoader.getRoutesBetweenStations(
                from: fromCode,
                to: toCode,
                date: getCurrentDate(),
                limit: pageSize,
                offset: offset,
                transfers: true
            )
            
            if reset {
                allSegments = result.segments ?? []
            } else {
                allSegments.append(contentsOf: result.segments ?? [])
            }
            
            hasMore = (result.segments?.count ?? 0) == pageSize
            
            isSearching = false
            isLoadingMore = false
            showCarriersList = true
        } catch {
            isSearching = false
            isLoadingMore = false
            
            print(error)
        }
    }
}
