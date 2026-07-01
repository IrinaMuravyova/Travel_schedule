//
//  CitiesListViewModel.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 29.06.2026.
//

import SwiftUI
import Combine

@MainActor
final class CitiesListViewModel: ObservableObject {
    
    @Published var cities: [Components.Schemas.Settlement] = []
    @Published var isLoading = false
    
    private let railwayStationTypes: Set<String> = [
        //        "station",        // станция
        "train_station",  // вокзал
        //        "platform",       // платформа
        //        "stop",          // остановочный пункт
        //        "checkpoint",    // блок-пост
        //        "post",          // пост
        //        "crossing",      // разъезд
        //        "overtaking_point" // обгонный пункт
    ]
    
    func load() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await AllStationsService.fetchAllStations()
            
            var allSettlements: [Components.Schemas.Settlement] = []
            
            if let countries = response.countries {
                for country in countries {
                    guard country.title == "Россия" else { continue }
                    
                    if let regions = country.regions {
                        for region in regions {
                            if let settlements = region.settlements {
                                allSettlements.append(contentsOf: settlements)
                            }
                        }
                    }
                }
            }
            
            let citiesWithRailwayStations = allSettlements.filter { settlement in
                guard let title = settlement.title,
                      !title.isEmpty else { return false }
                
                guard let stations = settlement.stations,
                      !stations.isEmpty else { return false }
                
                return stations.contains { station in
                    guard let stationType = station.station_type else { return false }
                    return railwayStationTypes.contains(stationType)
                }
            }   
            
            cities = citiesWithRailwayStations.sorted {
                ($0.title ?? "") < ($1.title ?? "")
            }
        } catch {
            print("Error loading stations:", error)
        }
    }
}
