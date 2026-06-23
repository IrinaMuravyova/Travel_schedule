//
//  CopyrightService.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 15.06.2026.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias CopyrightInfo = Components.Schemas.CopyrightResponse

protocol CopyrightServiceProtocol {
    func getCopyright(format: String?) async throws -> CopyrightInfo
}

final class CopyrightService: CopyrightServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getCopyright(format: String? = nil) async throws -> CopyrightInfo {
        let response = try await client.getCopyright(
            query: .init(apikey: apikey, format: format)
        )

        return try response.ok.body.json
    }
}

extension CopyrightService {
    static func testFetchCopyright() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )

                let service = CopyrightService(
                    client: client,
                    apikey: "c91d4c7a-40d5-4c5e-826c-2df03efaaea6"
                )

                print("Fetching copyright info...")

                let copyright = try await service.getCopyright()

                print("Successfully fetched copyright info:")
                print(copyright)

                if let data = copyright.copyright {
                    print("Text: \(data.text ?? "")")
                    print("URL: \(data.url ?? "")")
                }
            } catch {
                print("Error fetching copyright info: \(error)")
            }
        }
    }
}
