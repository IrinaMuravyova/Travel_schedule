//
//  CitiesListView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 29.06.2026.
//

import SwiftUI

struct CitiesListView: View {
    // MARK: - Properties
    @State var settlement: Components.Schemas.Settlement?
    @StateObject private var viewModel: CitiesListViewModel
    
    @Binding var selectedCity: Components.Schemas.Settlement?
    @Binding var selectedStation: Components.Schemas.Station?
    @Binding var isActive: Bool
    @Binding var selectedTab: ContentView.Tab
    
    @Environment(\.dismiss) private var dismiss
    
    private let mainTitle = NSLocalizedString("Choose city", comment: "")
    private let noResultsMessage = NSLocalizedString("No results found", comment: "")
    
    @Environment(\.requiredAllStationsLoader)
    private var allStationsLoader
    
    // MARK: - Init
    init(
        selectedCity: Binding<Components.Schemas.Settlement?>,
        selectedStation: Binding<Components.Schemas.Station?>,
        isActive: Binding<Bool>,
        selectedTab: Binding<ContentView.Tab>,
        allStationsLoader: AllStationsLoader
    ) {
        self._selectedCity = selectedCity
        self._selectedStation = selectedStation
        self._isActive = isActive
        self._selectedTab = selectedTab
        self._viewModel = StateObject(
            wrappedValue: CitiesListViewModel(allStationsLoader: allStationsLoader)
        )
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading cities")
            } else if let error = viewModel.networkError {
                
                ErrorScreenView(error: error)
                    .onAppear {
                        selectedTab = .settings
                    }
            } else {
                VStack {
                    SearchBar(searchText: $viewModel.searchText)
                    
                    if viewModel.filteredCities.isEmpty && !viewModel.searchText.isEmpty {
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
                                ForEach(viewModel.filteredCities, id: \.codes?.yandex_code) { city in
                                    NavigationLink {
                                        StationsListView(
                                            selectedStation: $selectedStation,
                                            isActive: $isActive,
                                            selectedCity: city,
                                        )
                                        .onAppear {
                                            settlement = city
                                            selectedCity = city
                                        }
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
        .toolbar(.hidden, for: .tabBar)
    }
}
