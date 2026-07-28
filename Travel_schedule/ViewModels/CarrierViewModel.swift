//
//  CarrierViewModel.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 14.07.2026.
//

import SwiftUI
import Combine

enum LocalizedString {
    static let email = NSLocalizedString(
        "Email",
        comment: "Carrier email"
    )
    
    static let phone = NSLocalizedString(
        "Phone",
        comment: "Carrier phone"
    )
    
    static let website = NSLocalizedString(
        "Website",
        comment: "Carrier website"
    )
    
    static let address = NSLocalizedString(
        "Address",
        comment: "Carrier address"
    )
}

@MainActor
final class CarrierViewModel: ObservableObject {
    @Published var carrier: Components.Schemas.Carrier?
    @Published var isLoading = false
    @Published var error: Error?
    
    private let carrierCode: String
    
    var contacts: [CarrierContact] {
        guard let carrier else { return [] }
        
        var result: [CarrierContact] = []
        
        if let email = carrier.email, !email.isEmpty {
            result.append(
                CarrierContact(
                    title: LocalizedString.email,
                    value: email
                )
            )
        }
        
        if let phone = carrier.phone, !phone.isEmpty {
            result.append(
                CarrierContact(
                    title: LocalizedString.phone,
                    value: phone
                )
            )
        }
        
        if let url = carrier.url, !url.isEmpty {
            result.append(
                CarrierContact(
                    title: LocalizedString.website,
                    value: url
                )
            )
        }
        
        if let address = carrier.address, !address.isEmpty {
            result.append(
                CarrierContact(
                    title: LocalizedString.address,
                    value: address
                )
            )
        }
        
        return result
    }
    
    private var carrierInfoLoader: CarrierInfoLoader
    
    init(
        carrierCode: String,
        carrierInfoLoader: CarrierInfoLoader
    ) {
        self.carrierCode = carrierCode
        self.carrierInfoLoader = carrierInfoLoader
    }
    
    func load() async {
        isLoading = true
        error = nil
        do {
            let carrier = try await carrierInfoLoader.getCarrierInfo(carrierCode: carrierCode)
            self.carrier = carrier
        } catch {
            self.error = error
            print("Failed to load carrier info:", error)
        }
        
        isLoading = false
    }
}
