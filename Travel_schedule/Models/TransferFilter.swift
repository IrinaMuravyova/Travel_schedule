//
//  TransferFilter.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 07.07.2026.
//

import Foundation

enum TransferFilter: CaseIterable {
    case withTransfers
    case withoutTransfers
    
    var title: String {
        switch self {
        case .withTransfers:
            return NSLocalizedString("Yes", comment: "")
        case .withoutTransfers:
            return NSLocalizedString("No", comment: "")
        }
    }
}
