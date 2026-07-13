//
//  SettingsView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 26.06.2026.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    @Binding var selectedTab: ContentView.Tab
    
    var body: some View {
        VStack {
            List {
                Toggle("Темная тема", isOn: $isDarkModeOn)
                    .frame(width: 375, height: 60)
                    .tint(.blue)
                    .listRowSeparator(.hidden)
                
                HStack {
                    Text("Пользовательское соглашение")
                    Spacer()
                    Image(.chevron)
                }
                .frame(width: 375, height: 60)
                .listRowSeparator(.hidden)
                
            }
            .listStyle(.plain)
            .font(.system(size: 17))
            .tracking(-0.41)
            
            Spacer()
            
            VStack(spacing: 16){
                Text("Copyright 1")
                Text("Copyright 2")
            }
            .font(.system(size: 12))
            .tracking(0.4)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 16))
        }
    }
}

