//
//  Travel_scheduleApp.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 08.06.2026.
//

import SwiftUI

@main
struct Travel_scheduleApp: App {
    private let networkClient: NetworkClient
    private let allStationsLoader: AllStationsLoader
    private let carrierInfoLoader: CarrierInfoLoader
    private let routesBetweenStationsLoader: RoutesBetweenStationsLoader
    
    init() {
        do {
            self.networkClient = try NetworkClient()
            self.allStationsLoader = AllStationsLoader(networkClient: networkClient)
            self.carrierInfoLoader = CarrierInfoLoader(networkClient: networkClient)
            self.routesBetweenStationsLoader = RoutesBetweenStationsLoader(networkClient: networkClient)
        } catch {
            fatalError("Failed to create NetworkClient: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.allStationsLoader, allStationsLoader)
                .environment(\.carrierInfoLoader , carrierInfoLoader)
                .environment(\.routesBetweenStationsLoader , routesBetweenStationsLoader)
        }
    }
}
