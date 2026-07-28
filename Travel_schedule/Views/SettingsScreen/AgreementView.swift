//
//  AgreementView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 28.07.2026.
//

import SwiftUI

struct AgreementView: View {
    @State private var viewModel: AgreementViewModel

    init(viewModel: AgreementViewModel) {
        _viewModel = State(initialValue: viewModel)
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
