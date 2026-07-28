//
//  RouteStationsLoader.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 15.06.2026.
//

import Foundation

actor RouteStationsLoader {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getRouteStations(
        uid: String,
        from: String? = nil,
        to: String? = nil,
        date: String? = nil,
        lang: String? = "ru_RU"
    ) async throws -> RouteStations {
        try await networkClient.fetchRouteStations(
            uid: uid,
            from: from,
            to: to,
            date: date,
            lang: lang
        )
    }
}
