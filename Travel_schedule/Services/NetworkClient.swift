//
//  NetworkClient.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 28.07.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias AllStations = Components.Schemas.AllStationsResponse
typealias CarrierInfo = Components.Schemas.CarrierResponse
typealias CopyrightInfo = Components.Schemas.CopyrightResponse
typealias NearestCity = Components.Schemas.NearestCityResponse
typealias NearestStations = Components.Schemas.StationsResponse
typealias RoutesBetweenStations = Components.Schemas.SegmentsResponse
typealias RouteStations = Components.Schemas.ThreadStationsResponse
typealias ScheduleResponse = Components.Schemas.ScheduleResponse

protocol NetworkClientProtocol {
    func fetchAllStations(
    ) async throws -> AllStations
    
    func fetchCarrierInfo(
        code: String
    ) async throws -> CarrierInfo
    
    func fetchCopyright() async throws -> CopyrightInfo
    
    func fetchNearestCity(
        lat: Double,
        lng: Double,
        distance: Int?
    ) async throws -> NearestCity
    
    func fetchNearestStations(
        lat: Double,
        lng: Double,
        distance: Int
    ) async throws -> NearestStations
    
    func fetchRoutesBetweenStations(
        from: String,
        to: String,
        date: String?,
        limit: Int?,
        offset: Int?,
        transfers: Bool?
    ) async throws -> RoutesBetweenStations
    
    func fetchRouteStations(
        uid: String,
        from: String?,
        to: String?,
        date: String?,
        lang: String?
    ) async throws -> RouteStations
    
    func fetchStationRoute(
        station: String,
        lang: String?
    ) async throws -> ScheduleResponse
}

actor NetworkClient: NetworkClientProtocol {
    // MARK: - Properties
    private let client: Client
    private let decoder = JSONDecoder()
    
    private let apiKey: String = "c91d4c7a-40d5-4c5e-826c-2df03efaaea6"
    private let defaultLanguage = "ru_RU"
    private let defaultFormat = "json"
    
    // MARK: - Init
    init(
        transport: ClientTransport = URLSessionTransport()
    ) throws {
        self.client = Client(
            serverURL: try Servers.Server1.url(),
            transport: transport
        )
    }
}

extension NetworkClient {
    // MARK: - AllStations
    func fetchAllStations(
    ) async throws -> AllStations {
        let response = try await client.getAllStations(
            query: .init(
                apikey: apiKey,
                lang: defaultLanguage,
                format: defaultFormat
            )
        )
        
        let responseBody = try await response.ok.body.html
        
        let limit = 50 * 1024 * 1024
        let fullData = try await Data(collecting: responseBody, upTo: limit)
        
        let allStations = try decoder.decode(AllStations.self, from: fullData)
        
        return allStations
    }
    
    // MARK: - CarrierInfo
    func fetchCarrierInfo(
        code: String
    ) async throws -> CarrierInfo {
        let response = try await client.getCarrierInfo(
            query: .init(
                apikey: apiKey,
                code: code,
                lang: defaultLanguage,
                format: defaultFormat
            )
        )
        
        return try await response.ok.body.json
    }
    
    // MARK: - CopyrightInfo
    func fetchCopyright() async throws -> CopyrightInfo {
        let response = try await client.getCopyright(
            query: .init(
                apikey: apiKey,
                format: defaultFormat)
        )
        
        return try await response.ok.body.json
    }
    
    // MARK: - NearestCity
    func fetchNearestCity(
        lat: Double,
        lng: Double,
        distance: Int?
    ) async throws -> NearestCity {
        let response = try await client.getNearestCity(
            query: .init(
                apikey: apiKey,
                lat: lat,
                lng: lng,
                distance: distance,
                lang: defaultLanguage,
                format: defaultFormat
            )
        )
        
        return try await response.ok.body.json
    }
    
    // MARK: - NearestStations
    func fetchNearestStations(
        lat: Double,
        lng: Double,
        distance: Int
    ) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
            apikey: apiKey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        
        return try await response.ok.body.json
    }
    
    // MARK: - RoutesBetweenStations
    func fetchRoutesBetweenStations(
        from: String,
        to: String,
        date: String?,
        limit: Int?,
        offset: Int?,
        transfers: Bool?
    ) async throws -> RoutesBetweenStations {
        let response = try await client.getRoutesBetweenStations(
            query: .init(
                apikey: apiKey,
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
        
        return try await response.ok.body.json
    }
    
    // MARK: - RouteStations
    func fetchRouteStations(
        uid: String,
        from: String?,
        to: String?,
        date: String?,
        lang: String?
    ) async throws -> RouteStations {
        let response = try await client.getRouteStations(
            query: .init(
                apikey: apiKey,
                uid: uid,
                from: from,
                to: to,
                format: "json",
                lang: lang,
                date: date
            )
        )
        
        return try await response.ok.body.json
    }
    
    // MARK: - ScheduleResponse
    func fetchStationRoute(
        station: String,
        lang: String?
    ) async throws -> ScheduleResponse {
        let response = try await client.getStationRoute(
            query: .init(
                apikey: apiKey,
                station: station,
                lang: lang,
                format: "json"
            )
        )
        
        return try await response.ok.body.json
    }
}
