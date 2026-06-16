//
//  CarrierInfoService.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 15.06.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias CarrierInfo = Components.Schemas.CarrierResponse

protocol CarrierInfoServiceProtocol {
    func getCarrierInfo(code: String, lang: String?) async throws -> CarrierInfo
}

final class CarrierInfoService: CarrierInfoServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getCarrierInfo(code: String, lang: String? = nil) async throws -> CarrierInfo {
        let response = try await client.getCarrierInfo(
            query: .init(
                apikey: apikey,
                code: code,
                lang: lang,
                format: "json"
            )
        )

        return try response.ok.body.json
    }
}

extension CarrierInfoService {
    static func testFetchCarrierInfo() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )

                let service = CarrierInfoService(
                    client: client,
                    apikey: "c91d4c7a-40d5-4c5e-826c-2df03efaaea6"
                )

                print("Fetching carrier info...")

                let carrier = try await service.getCarrierInfo(
                    code: "8565"
                )

                print("Successfully fetched carrier info:")
                print(carrier)
            } catch {
                print("Error fetching carrier info: \(error)")
            }
        }
    }
}
