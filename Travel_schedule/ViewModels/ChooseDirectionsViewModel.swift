//
//  ChooseDirectionsViewModel.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 24.07.2026.
//

import SwiftUI
import Combine

@MainActor
final class ChooseDirectionsViewModel: ObservableObject {
    // MARK: - Selected directions
    @Published var fromStation: Components.Schemas.Station?
    @Published var toStation: Components.Schemas.Station?
    
    @Published var fromSettlement: Components.Schemas.Settlement?
    @Published var toSettlement: Components.Schemas.Settlement?
    
    // MARK: - Routes
    let routesViewModel: RoutesViewModel
    
    // MARK: - Display values
    var fromDisplayName: String {
        fromStation?.title ?? ""
    }
    
    var toDisplayName: String {
        toStation?.title ?? ""
    }
    
    // MARK: - Init
    init(routesBetweenStationsLoader: RoutesBetweenStationsLoader) {
        self.routesViewModel = RoutesViewModel(routesBetweenStationsLoader: routesBetweenStationsLoader)
    }
    
    // MARK: - Actions
    func swapDirections() {
        let tempStation = fromStation
        fromStation = toStation
        toStation = tempStation
        
        let tempSettlement = fromSettlement
        fromSettlement = toSettlement
        toSettlement = tempSettlement
    }
    
    
    func prepareSearch() {
        let fromCityCode = fromSettlement?.codes?.yandex_code ?? ""
        let toCityCode = toSettlement?.codes?.yandex_code ?? ""
        
        routesViewModel.fromStation = fromStation
        routesViewModel.toStation = toStation
        
        routesViewModel.fromSettlement = fromSettlement
        routesViewModel.toSettlement = toSettlement
        
        routesViewModel.from = fromDisplayName
        routesViewModel.to = toDisplayName
        
        routesViewModel.fromCode = fromCityCode
        routesViewModel.toCode = toCityCode
    }
    
    
    func searchRoutes() {
        prepareSearch()
        routesViewModel.searchRoutes()
    }
    
    
    var canSearch: Bool {
        fromSettlement != nil &&
        toSettlement != nil
    }
}
