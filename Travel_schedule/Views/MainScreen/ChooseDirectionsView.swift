//
//  ChooseDirectionsView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 24.06.2026.
//

import SwiftUI

struct ChooseDirectionsView: View {
    @Binding var selectedTab: ContentView.Tab
    
    @State var fromStation: Components.Schemas.Station?
    @State var toStation: Components.Schemas.Station?
    
    @State var fromSettlement: Components.Schemas.Settlement?
    @State var toSettlement: Components.Schemas.Settlement?
    
    @State private var isFromActive = false
    @State private var isToActive = false
    @State private var isRoutesActive = false
    
    @StateObject private var viewModel = RoutesViewModel()
    
    var fromDisplayName: String {
        fromStation?.title ?? ""
    }
    
    var toDisplayName: String {
        toStation?.title ?? ""
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ScrollView(.horizontal, showsIndicators: false) {
                    StoriesView()
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
                                    direction: fromDisplayName,
                                    promt: NSLocalizedString("From", comment: "")
                                )
                            }
                            .buttonStyle(.plain)
                            
                            Button {
                                isToActive = true
                            } label: {
                                InputView(
                                    direction: toDisplayName,
                                    promt: NSLocalizedString("To", comment: "")
                                )
                            }
                            .buttonStyle(.plain)
                        }
                        .background(.white)
                        .cornerRadius(20)
                        
                        Button(action: {
                            swapDirections()
                            updateViewModelForSearch()
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
                
                if fromSettlement != nil && toSettlement != nil {
                    HStack {
                        Spacer()
                        
                        Button("Find") {
                            let fromCityCode = fromSettlement?.codes?.yandex_code
                            let toCityCode = toSettlement?.codes?.yandex_code
                            
                            viewModel.fromStation = fromStation
                            viewModel.toStation = toStation
                            viewModel.from = fromStation?.title ?? ""
                            viewModel.to = toStation?.title ?? ""
                            viewModel.fromCode = fromCityCode ?? ""
                            viewModel.toCode = toCityCode ?? ""
                            
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
                    selectedCity: $fromSettlement,
                    selectedStation: $fromStation,
                    isActive: $isFromActive,
                    selectedTab: $selectedTab
                )
            }
            .navigationDestination(isPresented: $isToActive) {
                CitiesListView(
                    selectedCity: $toSettlement,
                    selectedStation: $toStation,
                    isActive: $isToActive,
                    selectedTab: $selectedTab
                )
            }
            .navigationDestination(isPresented: $isRoutesActive) {
                RoutesListView(viewModel: viewModel)
            }
        }
    }
    
    private func swapDirections() {
        let tempStation = fromStation
        fromStation = toStation
        toStation = tempStation
        
        let tempSettlement = fromSettlement
        fromSettlement = toSettlement
        toSettlement = tempSettlement
    }
    
    private func updateViewModelForSearch() {
        let fromCityCode = fromSettlement?.codes?.yandex_code
        let toCityCode = toSettlement?.codes?.yandex_code
        
        viewModel.fromStation = fromStation
        viewModel.toStation = toStation
        viewModel.fromSettlement = fromSettlement
        viewModel.toSettlement = toSettlement
        viewModel.from = fromStation?.title ?? ""
        viewModel.to = toStation?.title ?? ""
        viewModel.fromCode = fromCityCode ?? ""
        viewModel.toCode = toCityCode ?? ""
    }
}
