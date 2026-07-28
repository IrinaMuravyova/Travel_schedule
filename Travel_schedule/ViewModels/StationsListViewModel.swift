//
//  StationsListViewModel.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 28.07.2026.
//

import Foundation
import Combine

@MainActor
final class StationsListViewModel: ObservableObject {
    // MARK: - Properties
    @Published var searchText = ""
    
    private let city: Components.Schemas.Settlement
    
    // MARK: - Competed properties
    var allStations: [Components.Schemas.Station] {
        let stations  =
        city.stations?.filter {
            $0.station_type == "train_station"
        } ?? []
        
        return stations
    }
    
    var filteredStations: [Components.Schemas.Station] {
        if searchText.isEmpty {
            return allStations
        } else {
            return allStations.filter { station in
                station.title?.localizedCaseInsensitiveContains(searchText) ?? false
            }
        }
    }
    
    var canSearch: Bool {
        filteredStations.isEmpty && !searchText.isEmpty
    }
    
    var cityTitle: String {
        city.title ?? ""
    }
    
    // MARK: - Init
    init(city: Components.Schemas.Settlement) {
        self.city = city
    }
    
    // MARK: - Functions
    func displayName(from station: Components.Schemas.Station) -> String {
        let fullTitle = station.title ?? ""
        
        if let openBracketIndex = fullTitle.firstIndex(of: "("),
           let closeBracketIndex = fullTitle.firstIndex(of: ")"),
           openBracketIndex < closeBracketIndex {
            
            let start = fullTitle.index(
                after: openBracketIndex
            )
            
            return String(fullTitle[start..<closeBracketIndex]).trimmingCharacters(in: .whitespaces)
        }
        
        return fullTitle
    }
}
