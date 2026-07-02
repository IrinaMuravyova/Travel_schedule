//
//  CitiesListView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 29.06.2026.
//

import SwiftUI

struct CitiesListView: View {
    @State private var searchString = ""
    @StateObject private var viewModel: CitiesListViewModel
    
    @Binding var selectedCity: String
    @Binding var isActive: Bool
    @Environment(\.dismiss) private var dismiss
    
    private let mainTitle = NSLocalizedString("Choose city", comment: "")
    private let noResultsMessage = NSLocalizedString("No results found", comment: "")
    
    var searchResults: [Components.Schemas.Settlement] {
        if searchString.isEmpty {
            return viewModel.cities
        } else {
            return viewModel.cities.filter { city in
                city.title?.localizedCaseInsensitiveContains(searchString) ?? false
            }
        }
    }
    
    init(selectedCity: Binding<String>, isActive: Binding<Bool>) {
        self._selectedCity = selectedCity
        self._isActive = isActive
        self._viewModel = StateObject(wrappedValue: CitiesListViewModel())
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading cities")
            } else {
                VStack {
                    SearchBar(searchText: $searchString)
                    
                    if searchResults.isEmpty && !searchString.isEmpty {
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
                                ForEach(searchResults, id: \.codes?.yandex_code) { city in
                                    NavigationLink {
                                        StationsListView(
                                            selectedStation: $selectedCity,
                                            isActive: $isActive,
                                            settlement: city
                                        )
                                    } label: {
                                        RowView(direction: city.title ?? "")
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(mainTitle)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.load()
        }
    }
}
