//
//  StationRoutesService.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 15.06.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleResponse = Components.Schemas.ScheduleResponse

protocol StationRouteServiceProtocol {
    func getStationRoute(station: String, lang: String?) async throws -> ScheduleResponse
}

final class StationRouteService: StationRouteServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getStationRoute(station: String, lang: String? = "ru_RU") async throws -> ScheduleResponse {
        let response = try await client.getStationRoute(
            query: .init(
                apikey: apikey,
                station: station,
                lang: lang,
                format: "json"
            )
        )

        return try response.ok.body.json
    }
}

extension StationRouteService {
    static func testFetchStationRoute() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )

                let service = StationRouteService(
                    client: client,
                    apikey: "c91d4c7a-40d5-4c5e-826c-2df03efaaea6"
                )

                print("Fetching station schedule...")
                let result = try await service.getStationRoute(
                    station: "s9600213"
                )

                print("Station: \(String(describing: result.station?.title))")
                if let schedule = result.schedule {
                    print("Routes count: \(schedule.count)")
                }

                print(result)
            } catch {
                print("Error fetching station schedule: \(error)")
            }
        }
    }
}
