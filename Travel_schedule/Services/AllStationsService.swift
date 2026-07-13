//
//  AllStationsService.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 15.06.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias AllStations = Components.Schemas.AllStationsResponse

protocol AllStationsServiceProtocol {
    func getAllStations(lang: String?, format: String?) async throws -> AllStations
}

final class AllStationsService: AllStationsServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getAllStations(lang: String? = "ru_RU", format: String? = "json") async throws -> AllStations {
        let response = try await client.getAllStations(query: .init(apikey: apikey))
        
        let responseBody = try response.ok.body.html
        
        let limit = 50 * 1024 * 1024
        let fullData = try await Data(collecting: responseBody, upTo: limit)
        
        let allStations = try JSONDecoder().decode(AllStations.self, from: fullData)
        
        return allStations
    }
}

extension AllStationsService {
    static func testFetchAllStations() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = AllStationsService(
                    client: client,
                    apikey: "c91d4c7a-40d5-4c5e-826c-2df03efaaea6"
                )
                
                print("Fetching all stations...")
                let stations = try await service.getAllStations(
                    lang: "ru_RU",
                    format: "json"
                )
                
                print("Successfully fetched stations:")
                print("Countries count: \(stations.countries?.count ?? 0)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    static func fetchAllStations() async throws -> AllStations {
        
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = AllStationsService(
            client: client,
            apikey: "c91d4c7a-40d5-4c5e-826c-2df03efaaea6"
        )
        
        let stations = try await service.getAllStations(
            lang: "ru_RU",
            format: "json"
        )
        
        return stations
    }
}
