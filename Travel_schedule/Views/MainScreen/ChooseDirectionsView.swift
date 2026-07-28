//
//  ChooseDirectionsView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 24.06.2026.
//

import SwiftUI

struct ChooseDirectionsView: View {
    @Binding var selectedTab: ContentView.Tab
    @State private var selectedStory: Story?
    @StateObject private var storyViewState = StoryViewState()
    
    @StateObject private var viewModel: ChooseDirectionsViewModel
    
    @State private var isFromActive = false
    @State private var isToActive = false
    @State private var isRoutesActive = false
    
    @Environment(\.requiredAllStationsLoader)
    private var allStationsLoader
    
    init(
        selectedTab: Binding<ContentView.Tab>,
        routesBetweenStationsLoader: RoutesBetweenStationsLoader
    ) {
        self._selectedTab = selectedTab
        self._viewModel = StateObject(
            wrappedValue: ChooseDirectionsViewModel(routesBetweenStationsLoader: routesBetweenStationsLoader)
        )
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ScrollView(.horizontal, showsIndicators: false) {
                    StoriesListView(
                        selectedStory: $selectedStory,
                        storyViewState: storyViewState
                    )
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
                }
                
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.blueUniversal)
                        .frame(width: 343, height: 128)
                    
                    HStack(spacing: 16) {
                        VStack(alignment: .leading) {
                            
                            Button {
                                isFromActive = true
                            } label: {
                                InputView(
                                    direction: viewModel.fromDisplayName,
                                    promt: NSLocalizedString("From", comment: "")
                                )
                            }
                            .buttonStyle(.plain)
                            
                            Button {
                                isToActive = true
                            } label: {
                                InputView(
                                    direction: viewModel.toDisplayName,
                                    promt: NSLocalizedString("To", comment: "")
                                )
                            }
                            .buttonStyle(.plain)
                        }
                        .background(.white)
                        .cornerRadius(20)
                        
                        Button(action: {
                            viewModel.swapDirections()
                        }) {
                            Image(.сhange)
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .tint(.blueUniversal)
                        }
                        .frame(width: 36, height: 36)
                        .background(.white)
                        .cornerRadius(20)
                    }
                    .padding(16)
                }
                
                if viewModel.canSearch {
                    HStack {
                        Spacer()
                        
                        Button("Find") {
                            viewModel.searchRoutes()
                            isRoutesActive = true
                        }
                        .frame(width: 150, height: 60)
                        .background(.blueUniversal)
                        .cornerRadius(16)
                        .foregroundStyle(.white)
                        .font(.system(size: 17, weight: .bold))
                        
                        Spacer()
                    }
                    Spacer()
                } else {
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $isFromActive) {
                CitiesListView(
                    selectedCity: $viewModel.fromSettlement,
                    selectedStation: $viewModel.fromStation,
                    isActive: $isFromActive,
                    selectedTab: $selectedTab,
                    allStationsLoader: allStationsLoader
                )
            }
            .navigationDestination(isPresented: $isToActive) {
                CitiesListView(
                    selectedCity: $viewModel.toSettlement,
                    selectedStation: $viewModel.toStation,
                    isActive: $isToActive,
                    selectedTab: $selectedTab,
                    allStationsLoader: allStationsLoader
                )
            }
            .navigationDestination(isPresented: $isRoutesActive) {
                RoutesListView(viewModel: viewModel.routesViewModel)
            }
            .fullScreenCover(item: $selectedStory) { story in
                StoryContentView(stories: [story], storyViewState: storyViewState)
            }
        }
    }
}
