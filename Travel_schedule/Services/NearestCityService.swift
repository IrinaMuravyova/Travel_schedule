//
//  NearestCityService.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 15.06.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestCity = Components.Schemas.NearestCityResponse

protocol NearestCityServiceProtocol {
    func getNearestCity(lat: Double, lng: Double, distance: Int?) async throws -> NearestCity
}

final class NearestCityService: NearestCityServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getNearestCity(lat: Double, lng: Double, distance: Int? = nil) async throws -> NearestCity {
        let response = try await client.getNearestCity(
            query: .init(
                apikey: apikey,
                lat: lat,
                lng: lng,
                distance: distance,
                lang: "ru_RU",
                format: "json"
            )
        )

        return try response.ok.body.json
    }
}

extension NearestCityService {
    static func testFetchCity() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )

                let service = NearestCityService(
                    client: client,
                    apikey: "c91d4c7a-40d5-4c5e-826c-2df03efaaea6"
                )

                print("Fetching nearest city...")
                let city = try await service.getNearestCity(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )

                print("Successfully fetched city:")
                print(city)
            } catch {
                print("Error fetching city: \(error)")
            }
        }
    }
}
