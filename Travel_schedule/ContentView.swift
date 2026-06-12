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
            NearestStationsService.testFetchStations()
        }
    }
}

#Preview {
    ContentView()
}
