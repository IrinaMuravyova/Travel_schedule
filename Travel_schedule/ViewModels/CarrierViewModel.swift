//
//  CarrierViewModel.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 14.07.2026.
//

import SwiftUI
import Combine

final class CarrierViewModel: ObservableObject {
    @Published var carrier: Components.Schemas.Carrier?
    @Published var isLoading = false
    @Published var error: Error?

    private let carrierCode: String
    
    init(carrierCode: String) {
        self.carrierCode = carrierCode
    }
    
    func load(code: String) async {
        isLoading = true
        error = nil
        do {
            let carrier = try await CarrierInfoService.fetchCarrierInfo(
                carrierCode: code
            )

            self.carrier = carrier
            
        } catch {
            self.error = error
            print("Failed to load carrier info:", error)
        }
        
        isLoading = false
    }
}
