//
//  StationsListView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 29.06.2026.
//

import SwiftUI

struct StationsListView: View {
    @StateObject private var viewModel: StationsListViewModel
    
    @Binding var selectedStation: Components.Schemas.Station?
    @Binding var isActive: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    private let title = NSLocalizedString("Choose station", comment: "")
    private let noResultsMessage = NSLocalizedString("Station not found", comment: "")
    
    init(
        selectedStation: Binding<Components.Schemas.Station?>,
        isActive: Binding<Bool>,
        selectedCity: Components.Schemas.Settlement
    ) {
        self._selectedStation = selectedStation
        self._isActive = isActive
        self._viewModel = StateObject(
            wrappedValue: StationsListViewModel(city: selectedCity)
        )
    }
    
    var body: some View {
        VStack {
            SearchBar(searchText:  $viewModel.searchText)
            
            if viewModel.canSearch {
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
                        ForEach(viewModel.filteredStations, id: \.codes?.yandex_code) { station in
                            Button {
                                selectedStation = station
                                isActive = false
                                dismiss()
                            } label: {
                                RowView(direction: viewModel.displayName(from: station))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .navigationTitle(viewModel.cityTitle)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}
