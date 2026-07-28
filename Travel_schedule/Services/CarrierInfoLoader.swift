//
//  CarrierInfoLoader.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 15.06.2026.
//

import Foundation

actor CarrierInfoLoader {
    private let networkClient: NetworkClient
    private var cachedCarriers: [String: Components.Schemas.Carrier] = [:]
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getCarrierInfo(carrierCode: String) async throws -> Components.Schemas.Carrier? {
        if let cachedCarrier = cachedCarriers[carrierCode] {
            return cachedCarrier
        }
        
        let response = try await networkClient.fetchCarrierInfo(
            code: carrierCode
        )
        
        guard let carrier = response.carrier else {
            return nil
        }
        cachedCarriers[carrierCode] = carrier
        
        return carrier
    }
}
