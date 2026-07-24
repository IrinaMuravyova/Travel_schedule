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
    @State private var showAgreement = false
    
    let agreementURL = "https://yandex.ru/legal/practicum_offer"
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Toggle("Dark Mode", isOn: $isDarkModeOn)
                        .frame(height: 60)
                        .tint(.blue)
                        .listRowSeparator(.hidden)
                    
                    Button {
                        showAgreement = true
                    } label: {
                        HStack {
                            Text("Users Agreement")
                            Spacer()
                            Image(.chevron)
                        }
                        .frame(height: 60)
                        .listRowSeparator(.hidden)
                    }
                    .buttonStyle(.plain)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .font(.system(size: 17))
                .tracking(-0.41)
                
                Spacer()
                
                VStack(spacing: 16){
                    Text("The application uses the Yandex.Schedules API.")
                    Text("Version")
                }
                .font(.system(size: 12))
                .tracking(0.4)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 16))
            }
            .navigationDestination(isPresented: $showAgreement) {
                if let url = URL(string: agreementURL) {
                    AgreementView(
                        url: url,
                        isDarkMode: isDarkModeOn
                    )
                }
            }
        }
    }
}

struct AgreementView: View {
    let url: URL
    let isDarkMode: Bool
    
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            CopyrightWebView(
                url: url,
                isDarkMode: isDarkMode,
                isLoading: $isLoading
            )
            
            if isLoading {
                ProgressView()
                    .scaleEffect(1.5)
            }
        }
        .navigationTitle("Users Agreement")
        .navigationBarTitleDisplayMode(.inline)
    }
}
