//
//  RoutesRowView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 02.07.2026.
//

import SwiftUI

struct RoutesRowView: View {
    let route: Components.Schemas.Route
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(.lightGray)
            
            VStack(alignment: .leading) {
                HStack(spacing: 8) {
                    Image(route.carrier?.logo ?? "")
                        .resizable()
                        .frame(width: 38, height: 38)
                        .cornerRadius(12)
                    
                    VStack (alignment: .leading) {
                        Text(route.carrier?.title ?? "Unknown carrier")
                            .font(.system(size: 17, weight: .regular))
                            .tracking(-0.41)
                        if let transfers = route.transfers, transfers > 0 {
                            Text("С пересадкой в \(route.departure.station)")
                                .foregroundStyle(.red)
                                .frame(alignment: .bottom)
                                .font(.system(size: 12, weight: .regular))
                                .tracking(0.4)
                        } else {
                            Text("Прямой рейс")
                                .foregroundStyle(.green)
                                .font(.system(size: 12, weight: .regular))
                                .tracking(0.4)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(formatDate(route.departure.date))
                        .frame(alignment: .topTrailing)
                        .font(.system(size: 12))
                        .tracking(0.4)
                }
                .padding(EdgeInsets(top: 14, leading: 14, bottom: 2, trailing: 14))
                
                HStack {
                    Text(formatTime(route.departure.time))
                        .frame(width: 46, height: 20)
                        .tracking(-0.41)
                    
                    TimeSeparatorView()
                    
                    Text(formatDuration(route.duration))
                        .frame(width: 56, height: 14)
                        .font(.system(size: 12))
                        .tracking(0.4)
                    
                    TimeSeparatorView()
                    
                    Text(formatTime(route.arrival.time))
                        .frame(width: 46, height: 20)
                        .tracking(-0.41)
                }
                .padding(EdgeInsets(top: 2, leading: 14, bottom: 14, trailing: 14))
            }
        }
        .listRowSeparator(.hidden)
    }
    
    // MARK: - Helper Functions
    private func formatDate(_ date: String) -> String {
        // Форматирование даты из "2026-07-02" в "2 июля"
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "ru_RU")
        outputFormatter.dateFormat = "d MMMM"
        
        if let date = inputFormatter.date(from: date) {
            return outputFormatter.string(from: date)
        }
        return date
    }
    
    private func formatTime(_ time: String) -> String {
        // Форматирование времени из "22:30:00" в "22:30"
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "HH:mm:ss"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:mm"
        
        if let date = inputFormatter.date(from: time) {
            return outputFormatter.string(from: date)
        }
        return time
    }
    
    private func formatDuration(_ duration: Int) -> String {
        // Преобразование длительности из минут в часы и минуты
        let hours = duration / 60
        let minutes = duration % 60
        
        if hours > 0 && minutes > 0 {
            return "\(hours) ч \(minutes) мин"
        } else if hours > 0 {
            return "\(hours) ч"
        } else {
            return "\(minutes) мин"
        }
    }
}

#Preview {
    RoutesRowView()
}
