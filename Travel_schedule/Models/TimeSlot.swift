//
//  TimeSlot.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 07.07.2026.
//

import Foundation

enum TimeSlot: CaseIterable, Hashable {
    case morning
    case day
    case evening
    case night
    
    var title: String {
        switch self {
        case .morning:
            return NSLocalizedString("Time Morning", comment: "")
        case .day:
            return NSLocalizedString("Time Day", comment: "")
        case .evening:
            return NSLocalizedString("Time Evening", comment: "")
        case .night:
            return NSLocalizedString("Time Night", comment: "")
        }
    }
}
