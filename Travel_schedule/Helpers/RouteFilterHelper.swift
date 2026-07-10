//
//  RouteFilterHelper.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 08.07.2026.
//

import Foundation

func isTimeInRange(time: String, timeSlot: TimeSlot) -> Bool {
    let formatter = ISO8601DateFormatter()

    guard let date = formatter.date(from: time) else {
        return false
    }

    let hour = Calendar.current.component(.hour, from: date)

    switch timeSlot {
    case .morning:
        return hour >= 6 && hour < 12
    case .day:
        return hour >= 12 && hour < 18
    case .evening:
        return hour >= 18 && hour < 24
    case .night:
        return hour >= 0 && hour < 6
    }
}
