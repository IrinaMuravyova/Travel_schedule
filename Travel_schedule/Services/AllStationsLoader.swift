//
//  AllStationsLoader.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 15.06.2026.


import Foundation

actor AllStationsLoader{
    private let networkClient: NetworkClient
    private var cachedStations: AllStations?
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getAllStations() async throws -> AllStations {
        if let cachedStations {
            return cachedStations
        }
        
        
        let stations = try await networkClient.fetchAllStations()
        
        cachedStations = stations
        
        return stations
    }
}
