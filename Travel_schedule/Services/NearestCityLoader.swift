//
//  NearestCityLoader.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 15.06.2026.
//

import Foundation

actor NearestCityLoader {
    private let networkClient: NetworkClient
    private var cachedCity: NearestCity?
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getNearestCity(lat: Double, lng: Double, distance: Int? = nil) async throws -> NearestCity {
        if let cachedCity {
            return cachedCity
        }
        
        let city = try await networkClient.fetchNearestCity(
            lat: lat,
            lng: lng,
            distance: distance
        )
        
        cachedCity = city
        
        return city
    }
}
