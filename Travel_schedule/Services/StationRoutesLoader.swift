//
//  StationRoutesLoader.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 15.06.2026.
//

import Foundation

actor StationRouteLoader {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getStationRoute(station: String, lang: String? = "ru_RU") async throws -> ScheduleResponse {
        try await networkClient.fetchStationRoute(
            station: station,
            lang: lang
        )
    }
}
