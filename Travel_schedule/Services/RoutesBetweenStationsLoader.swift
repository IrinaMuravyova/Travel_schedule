//
//  RoutesBetweenStationsLoader.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 15.06.2026.
//

import Foundation

actor RoutesBetweenStationsLoader {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getRoutesBetweenStations(
        from: String,
        to: String,
        date: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        transfers: Bool? = nil
    ) async throws -> RoutesBetweenStations {
        try await networkClient.fetchRoutesBetweenStations(
            from: from,
            to: to,
            date: date,
            limit: limit,
            offset: offset,
            transfers: transfers
        )
    }
}
