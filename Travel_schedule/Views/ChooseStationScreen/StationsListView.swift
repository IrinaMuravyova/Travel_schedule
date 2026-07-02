//
//  StationsListView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 29.06.2026.
//

import SwiftUI

struct StationsListView: View {
    @State private var searchString = ""
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedStation: String
    @Binding var isActive: Bool
    
    let settlement: Components.Schemas.Settlement
    
    private let title = NSLocalizedString("Choose station", comment: "")
    private let noResultsMessage = NSLocalizedString("Station not found", comment: "")
    
    private var allStations: [Components.Schemas.Station] {
        settlement.stations?.filter {
            $0.station_type == "train_station"
        } ?? []
    }
    
    private var filteredStations: [Components.Schemas.Station] {
        if searchString.isEmpty {
            return allStations
        } else {
            return allStations.filter { station in
                station.title?.localizedCaseInsensitiveContains(searchString) ?? false
            }
        }
    }
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchString)
            
            if filteredStations.isEmpty && !searchString.isEmpty {
                VStack(spacing: 16) {
                    Spacer()
                    
                    Text(noResultsMessage)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(filteredStations, id: \.codes?.yandex_code) { station in
                            Button {
                                selectedStation = station.title ?? ""
                                isActive = false
                                dismiss()
                            } label: {
                                RowView(direction: extractStationName(from: station.title ?? ""))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .navigationTitle(settlement.title ?? "")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    private func extractStationName(from fullTitle: String) -> String {
        if let openBracketIndex = fullTitle.firstIndex(of: "("),
           let closeBracketIndex = fullTitle.firstIndex(of: ")"),
           openBracketIndex < closeBracketIndex {
            
            let start = fullTitle.index(after: openBracketIndex)
            return String(fullTitle[start..<closeBracketIndex]).trimmingCharacters(in: .whitespaces)
        }
        
        return fullTitle
    }
}
