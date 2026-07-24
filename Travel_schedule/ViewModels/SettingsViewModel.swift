//
//  SettingsViewModel.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 24.07.2026.
//

import Foundation
import Observation

@Observable
final class SettingsViewModel {
    var isDarkModeOn: Bool {
        didSet {
            UserDefaults.standard.set(isDarkModeOn, forKey: "isDarkModeOn")
        }
    }
    
    var showAgreement = false

    init() {
        self.isDarkModeOn = UserDefaults.standard.bool(forKey: "isDarkModeOn")
    }

    func openAgreement() {
        showAgreement = true
    }
}
