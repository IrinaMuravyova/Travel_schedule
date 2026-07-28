//
//  EnvironmentValues+Dependencies.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 28.07.2026.
//

import SwiftUI

private struct AllStationsLoaderKey: EnvironmentKey {
    static let defaultValue: AllStationsLoader? = nil
}

private struct CarrierInfoLoaderKey: EnvironmentKey {
    static let defaultValue: CarrierInfoLoader? = nil
}

private struct RoutesBetweenStationsLoaderKey: EnvironmentKey {
    static let defaultValue: RoutesBetweenStationsLoader? = nil
}

extension EnvironmentValues {
    var allStationsLoader: AllStationsLoader? {
        get {
            self[AllStationsLoaderKey.self]
        }
        set {
            self[AllStationsLoaderKey.self] = newValue
        }
    }
    
    var requiredAllStationsLoader: AllStationsLoader {
        guard let loader = self[AllStationsLoaderKey.self] else {
            fatalError("AllStationsLoader is not configured")
        }
        
        return loader
    }
    
    var carrierInfoLoader: CarrierInfoLoader? {
        get {
            self[CarrierInfoLoaderKey.self]
        }
        set {
            self[CarrierInfoLoaderKey.self] = newValue
        }
    }
    
    var requiredCarrierInfoLoader: CarrierInfoLoader {
        guard let loader = self[CarrierInfoLoaderKey.self] else {
            fatalError("CarrierInfoLoader is not configured")
        }
        
        return loader
    }
    
    var routesBetweenStationsLoader: RoutesBetweenStationsLoader? {
        get {
            self[RoutesBetweenStationsLoaderKey.self]
        }
        set {
            self[RoutesBetweenStationsLoaderKey.self] = newValue
        }
    }
    
    var requiredRoutesBetweenStationsLoader: RoutesBetweenStationsLoader {
        guard let loader = self[RoutesBetweenStationsLoaderKey.self] else {
            fatalError("RoutesBetweenStationsLoader is not configured")
        }
        
        return loader
    }
}
