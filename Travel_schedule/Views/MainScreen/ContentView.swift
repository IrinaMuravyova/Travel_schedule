//
//  ContentView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 08.06.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView(){
            ChooseDirectionsView()
                .tabItem {
                    Label("", image: .schedule)
                }
            
            Spacer()
            
            SettingsView()
                .tabItem {
                    Label("", image: .settings)
                }
        }
        .tint(.blackDay)
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
    }
}

#Preview {
    ContentView()
}
