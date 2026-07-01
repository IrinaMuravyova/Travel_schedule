//
//  StationsListView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 29.06.2026.
//

import SwiftUI

struct StationsListView: View {
    let settlement: Components.Schemas.Settlement

    var body: some View {
        let stations = settlement.stations?.filter {
                    $0.station_type == "train_station"
                } ?? []
        
        Group {
                    if stations.isEmpty {
                        Text("No train stations")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        List(stations, id: \.codes?.yandex_code) { station in
                            Text(station.title ?? "")
                        }
                        .listStyle(.plain)
                    }
                }
                .navigationTitle(settlement.title ?? "")
                .navigationBarTitleDisplayMode(.inline)
//        let stations = settlement.stations ?? []
//        
//        List(stations, id: \.codes?.yandex_code) { station in
//            Text(station.title ?? "")
//        }
//        .navigationTitle(settlement.title ?? "")
    }
}
