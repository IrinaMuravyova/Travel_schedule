//
//  RouteStationsService.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 15.06.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias RouteStations = Components.Schemas.ThreadStationsResponse

protocol RouteStationsServiceProtocol {
    func getRouteStations(
        uid: String,
        from: String?,
        to: String?,
        date: String?,
        lang: String?
    ) async throws -> RouteStations
}

final class RouteStationsService: RouteStationsServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getRouteStations(
        uid: String,
        from: String? = nil,
        to: String? = nil,
        date: String? = nil,
        lang: String? = "ru_RU"
    ) async throws -> RouteStations {
        let response = try await client.getRouteStations(
            query: .init(
                apikey: apikey,
                uid: uid,
                from: from,
                to: to,
                format: "json",
                lang: lang,
                date: date
            )
        )

        return try response.ok.body.json
    }
}

extension RouteStationsService {
    static func testFetchRouteStations() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )

                let service = RouteStationsService(
                    client: client,
                    apikey: "c91d4c7a-40d5-4c5e-826c-2df03efaaea6"
                )

                print("Fetching route stations...")
                let result = try await service.getRouteStations(
                    uid: "DP-6569_260629_c9144_12",
                    from: nil,
                    to: nil
                )

                print("Successfully fetched route stations:")
                print(result)
            } catch {
                print("Error fetching route stations: \(error)")
            }
        }
    }
}
