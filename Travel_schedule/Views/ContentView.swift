//
//  ContentView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 08.06.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear{
            RoutesBetweenStationsService.testFetchRoutes()
            StationRouteService.testFetchStationRoute()
            RouteStationsService.testFetchRouteStations()
            NearestStationsService.testFetchStations()
            NearestCityService.testFetchCity()
            CarrierInfoService.testFetchCarrierInfo()
            AllStationsService.testFetchAllStations()
            CopyrightService.testFetchCopyright()
        }
    }
}

#Preview {
    ContentView()
}
