//
//  SettingsView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 26.06.2026.
//

import SwiftUI

struct SettingsView: View {
    @Binding var selectedTab: ContentView.Tab
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Toggle("Dark Mode", isOn: $viewModel.isDarkModeOn)
                        .frame(height: 60)
                        .tint(.blue)
                        .listRowSeparator(.hidden)
                    
                    Button {
                        viewModel.openAgreement()
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
            .navigationDestination(isPresented: $viewModel.showAgreement) {
                AgreementView(
                    viewModel: AgreementViewModel(
                        url: viewModel.agreementURL,
                        isDarkMode: viewModel.isDarkModeOn
                    )
                )
            }
        }
    }
}
