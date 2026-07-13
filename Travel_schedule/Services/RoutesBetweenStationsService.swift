//
//  RoutesBetweenStationsService.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 15.06.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias RoutesBetweenStations = Components.Schemas.SegmentsResponse

protocol RoutesBetweenStationsServiceProtocol {
    func getRoutesBetweenStations(
        from: String,
        to: String,
        date: String?,
        limit: Int?,
        offset: Int?,
        transfers: Bool?
    ) async throws -> RoutesBetweenStations
}

final class RoutesBetweenStationsService: RoutesBetweenStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getRoutesBetweenStations(
        from: String,
        to: String,
        date: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        transfers: Bool? = nil
    ) async throws -> RoutesBetweenStations {
        
        let response = try await client.getRoutesBetweenStations(
            query: .init(
                apikey: apikey,
                from: from,
                to: to,
                date: date,
                format: "json",
                lang: "ru_RU",
                limit: limit,
                offset: offset,
                transfers: transfers
            )
        )
        
        return try response.ok.body.json
    }
}

extension RoutesBetweenStationsService {
    static func testFetchRoutes() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = RoutesBetweenStationsService(
                    client: client,
                    apikey: "c91d4c7a-40d5-4c5e-826c-2df03efaaea6"
                )
                
                print("Fetching routes...")
                let routes = try await service.getRoutesBetweenStations(
                    from: "s9602490",
                    to: "s9600213",
                    date: "2026-06-15",
                    limit: 10,
                    transfers: false
                )
                
                print("Successfully fetched routes:")
                print(routes)
            } catch {
                print("Error fetching routes: \(error)")
            }
        }
    }
    
    static func fetchRoutes(
        from: String,
        to: String,
        date: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        transfers: Bool? = nil
    ) async throws -> RoutesBetweenStations {
        
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = RoutesBetweenStationsService(
            client: client,
            apikey: "c91d4c7a-40d5-4c5e-826c-2df03efaaea6"
        )
        do {
            let routes = try await service.getRoutesBetweenStations(
                from: from,
                to: to,
                date: date,
                limit: limit,
                offset: offset,
                transfers: transfers
            )
            
            return routes
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
