//
//  AgreementViewModel.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 28.07.2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class AgreementViewModel {
    let url: URL
    let isDarkMode: Bool

    var isLoading = true

    init(url: URL, isDarkMode: Bool) {
        self.url = url
        self.isDarkMode = isDarkMode
    }
}
