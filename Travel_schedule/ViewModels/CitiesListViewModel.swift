//
//  CitiesListViewModel.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 29.06.2026.
//

import SwiftUI
import Combine

@MainActor
final class CitiesListViewModel: ObservableObject {

    @Published var cities: [Components.Schemas.Settlement] = []
    @Published var isLoading = false

    func load() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let response = try await AllStationsService.fetchAllStations()

            let countries = response.countries ?? []

            let regions = countries.flatMap { country in
                country.regions ?? []
            }

            let settlements = regions.flatMap { region in
                region.settlements ?? []
            }

            cities = settlements.sorted {
                ($0.title ?? "") < ($1.title ?? "")
            }
//            let response = try await AllStationsService.fetchAllStations()
//            let countries = response.countries
////            let region = response.countries?.first?.regions
////            let settlement = response.countries?.first?.regions?.first?.settlements
//            let regions = countries.flatMap(\.regions)
//            cities = response.countries
//                .flatMap(\.regions)
//                .flatMap(\.settlements)
//                .sorted { $0.title < $1.title }
        } catch {
            print("Error loading stations:", error)
        }
    }
}
