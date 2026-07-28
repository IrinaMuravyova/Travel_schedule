//
//  SettingsViewModel.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 24.07.2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class SettingsViewModel {
    var isDarkModeOn: Bool {
        didSet {
            UserDefaults.standard.set(isDarkModeOn, forKey: "isDarkModeOn")
        }
    }
    
    var showAgreement = false
    
    let agreementURL: URL

    init() {
        self.isDarkModeOn = UserDefaults.standard.bool(forKey: "isDarkModeOn")
        
        guard let url = URL(
            string: "https://yandex.ru/legal/practicum_offer"
        ) else {
            fatalError("Invalid agreement URL")
        }
        
        self.agreementURL = url
    }

    func openAgreement() {
        showAgreement = true
    }
}
