//
//  NetworkDebug.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 28.07.2026.
//

#if DEBUG

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

enum NetworkDebug {
    static func testFetchAllStations() {
        Task {
            do {
                let client = try NetworkClient()
                let loader = AllStationsLoader(networkClient: client)
                
                print("Fetching all stations...")
                let stations = try await loader.getAllStations()
                
                print("Successfully fetched stations:")
                print("Countries count: \(stations.countries?.count ?? 0)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    static func testFetchCarrierInfo() {
        Task {
            do {
                let client = try NetworkClient()
                let loader = CarrierInfoLoader(networkClient: client)
                
                print("Fetching carrier info...")
                
                let carrier = try await loader.getCarrierInfo(
                    carrierCode: "8565"
                )
                
                print("Successfully fetched carrier info:")
                print(carrier)
            } catch {
                print("Error fetching carrier info: \(error)")
            }
        }
    }
    
    static func testFetchCopyright() {
        Task {
            do {
                let client = try NetworkClient()
                let loader = CopyrightLoader(networkClient: client)
                
                print("Fetching copyright info...")
                
                let copyright = try await loader.getCopyright()
                
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
    
    static func testFetchCity() {
        Task {
            do {
                let client = try NetworkClient()
                let loader = NearestCityLoader(networkClient: client)
                
                print("Fetching nearest city...")
                let city = try await loader.getNearestCity(
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
    
    static func testFetchStations() {
        Task {
            do {
                let client = try NetworkClient()
                let loader = NearestStationsLoader(networkClient: client)
                
                print("Fetching stations...")
                let stations = try await loader.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )
                
                print("Successfully fetched stations: \(stations)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    static func testFetchRoutes() {
        Task {
            do {
                let client = try NetworkClient()
                let loader = RoutesBetweenStationsLoader(networkClient: client)
                
                print("Fetching routes...")
                let routes = try await loader.getRoutesBetweenStations(
                    from: "s9602490",
                    to: "s9600213",
                    date: "2026-06-15",
                    limit: 10,
                    transfers: false
                )
                
                print("Successfully fetched routes:")
                print(routes)
            } catch {
                print("Error fetching routes: \(error)")
            }
        }
    }
    
    static func testFetchRouteStations() {
        Task {
            do {
                let client = try NetworkClient()
                let loader = RouteStationsLoader(networkClient: client)
                
                print("Fetching route stations...")
                let result = try await loader.getRouteStations(
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
    
    static func testFetchStationRoute() {
        Task {
            do {
                let client = try NetworkClient()
                let loader = StationRouteLoader(networkClient: client)
                
                print("Fetching station schedule...")
                let result = try await loader.getStationRoute(
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

#endif
