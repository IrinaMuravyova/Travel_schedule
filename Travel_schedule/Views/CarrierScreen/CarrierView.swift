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
    
    private let carrierCode: String
    
    init(carrierCode: String) {
        _viewModel = StateObject(
            wrappedValue: CarrierViewModel(
                carrierCode: carrierCode
            )
        )
        self.carrierCode = carrierCode
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
                            if let email = carrier.email, !email.isEmpty {
                                ContactInfoView(
                                    title: "Email",
                                    details: email
                                )
                            }
                            
                            if let phone = carrier.phone, !phone.isEmpty {
                                ContactInfoView(
                                    title: "Phone",
                                    details: phone
                                )
                            }
                            
                            if let url = carrier.url, !url.isEmpty {
                                ContactInfoView(
                                    title: "Website",
                                    details: url
                                )
                            }
                            
                            if let address = carrier.address, !address.isEmpty {
                                ContactInfoView(
                                    title: "Address",
                                    details: address
                                )
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(16)
                }
            } else {
                Text("Couldn't upload information")
            }
        }
        .navigationTitle("Carrier info")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.load(code: carrierCode)
        }
    }
}
