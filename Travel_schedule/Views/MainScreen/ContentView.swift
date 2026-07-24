//
//  ContentView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 08.06.2026.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    @State private var selectedTab = Tab.schedule
    @Environment(\.colorScheme) private var colorScheme
    
    enum Tab {
        case schedule
        case settings
    }
    
    var body: some View {
        TabView(selection: $selectedTab){
            ChooseDirectionsView(selectedTab: $selectedTab)
                .tabItem {
                    Label("", image: .schedule)
                }
                .tag(Tab.schedule)
            
            Spacer()
            
            SettingsView(selectedTab: $selectedTab)
                .tabItem {
                    Label("", image: .settings)
                }
                .tag(Tab.settings)
        }
        .tint(isDarkModeOn ? .white : .blackDay)
        .onAppear{
            //            RoutesBetweenStationsService.testFetchRoutes()
            //            StationRouteService.testFetchStationRoute()
            //            RouteStationsService.testFetchRouteStations()
            //            NearestStationsService.testFetchStations()
            //            NearestCityService.testFetchCity()
            //            CarrierInfoService.testFetchCarrierInfo()
            //            AllStationsService.testFetchAllStations()
            //            CopyrightService.testFetchCopyright()
        }
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
