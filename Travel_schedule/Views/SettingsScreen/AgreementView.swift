//
//  AgreementView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 28.07.2026.
//

import SwiftUI

struct AgreementView: View {
    @StateObject private var viewModel: AgreementViewModel

    init(viewModel: AgreementViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            CopyrightWebView(
                url: viewModel.url,
                isDarkMode: viewModel.isDarkMode,
                isLoading: $viewModel.isLoading
            )

            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
            }
        }
        .navigationTitle("Users Agreement")
        .navigationBarTitleDisplayMode(.inline)
    }
}
