//
//  AgreementViewModel.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 28.07.2026.
//

import Foundation
import Combine

@MainActor
final class AgreementViewModel: ObservableObject {
    let url: URL
    let isDarkMode: Bool

    @Published var isLoading = true

    init(url: URL, isDarkMode: Bool) {
        self.url = url
        self.isDarkMode = isDarkMode
    }
}
