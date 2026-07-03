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
    @Published var routes: RoutesBetweenStations?
    
    func searchRoutes() {
        guard !fromCode.isEmpty, !toCode.isEmpty else { return }
        
        isSearching = true
        
        let date = getCurrentDate()
        
        Task {
            do {
                let routes = try await RoutesBetweenStationsService.fetchRoutes(
                    from: fromCode,
                    to: toCode,
                    date: date,
                    limit: 10,
                    transfers: false
                )
                
                self.routes = routes
                self.isSearching = false
                self.showCarriersList = true
            } catch {
                print(error.localizedDescription)
                self.isSearching = false
            }
        }
    }
    
    func swapDirections() {
        let temp = from
        from = to
        to = temp
        
        let tempCode = fromCode
        fromCode = toCode
        toCode = tempCode
        
        let tempStation = fromStation
        fromStation = toStation
        toStation = tempStation
        
        let tempSettlement = fromSettlement
        fromSettlement = toSettlement
        toSettlement = tempSettlement
    }
    
    private func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
}
