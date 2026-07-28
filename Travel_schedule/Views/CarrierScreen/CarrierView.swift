//
//  CarrierView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 14.07.2026.
//

import SwiftUI

struct CarrierView: View {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var viewModel: CarrierViewModel
    
    init(carrierCode: String) {
        _viewModel = StateObject(
            wrappedValue: CarrierViewModel(
                carrierCode: carrierCode
            )
        )
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let carrier = viewModel.carrier {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        AsyncImage(url: URL(string: carrier.logo ?? "")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(24)
                                .frame(height: 104)
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.clear)
                                .frame(height: 104)
                        }
                        
                        Text(carrier.title ?? "")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(colorScheme == .dark ? .white : .blackDay)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(viewModel.contacts) { contact in
                                ContactInfoView(
                                    title: contact.title,
                                    details: contact.value
                                )
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(16)
                }
            } else if let error = viewModel.error {
                Text(error.localizedDescription)
            }
        }
        .navigationTitle("Carrier info")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.load()
        }
    }
}
