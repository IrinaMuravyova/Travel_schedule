//
//  NearestStationsLoader.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 09.06.2026.
//

import Foundation

actor NearestStationsLoader {
    private let networkClient: NetworkClient
    private var cachedStations: NearestStations?
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        if let cachedStations {
            return cachedStations
        }
        
        let stations = try await networkClient.fetchNearestStations(
            lat: lat,
            lng: lng,
            distance: distance
        )
        
        cachedStations = stations
        
        return stations
    }
}
