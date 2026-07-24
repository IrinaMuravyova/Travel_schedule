//
//  RoutesRowView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 02.07.2026.
//

import SwiftUI

struct RoutesRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let route: Components.Schemas.Segment
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(.lightGray)
                .frame(height: 104)
            
            VStack(alignment: .leading) {
                HStack(spacing: 8) {
                    //                    SVGImage(url: route.thread?.carrier?.logo_svg)
                    //                        .frame(width: 38, height: 38)
                    //                        .cornerRadius(12)
                    AsyncImage(url: URL(string: route.thread?.carrier?.logo ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 38, height: 38, alignment: .leading)
                            .cornerRadius(12)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 38, height: 38)
                    }
                    
                    VStack (alignment: .leading) {
                        Text(route.thread?.carrier?.title ?? "Unknown carrier")
                            .font(.system(size: 17, weight: .regular))
                            .tracking(-0.41)
                            .foregroundStyle(.blackDay)
                        
                        if route.has_transfers == true {
                            let transferStation = route.to?.title ?? "Unknown station"
                            Text("Transfer at \(transferStation)")
                                .foregroundStyle(.red)
                                .frame(alignment: .bottom)
                                .font(.system(size: 12, weight: .regular))
                                .tracking(0.4)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(formatDate(route.start_date ?? ""))
                        .frame(alignment: .topTrailing)
                        .font(.system(size: 12))
                        .tracking(0.4)
                        .foregroundStyle(.blackDay)
                }
                .padding(EdgeInsets(top: 14, leading: 14, bottom: 2, trailing: 14))
                
                HStack {
                    Text(formatTimeFromDate(route.departure))
                        .frame(width: 46, height: 20)
                        .tracking(-0.41)
                        .foregroundStyle(.blackDay)
                    
                    TimeSeparatorView()
                    
                    Text(formatDuration(route.duration ?? 0))
                        .frame(width: 56, height: 14)
                        .font(.system(size: 12))
                        .tracking(0.4)
                        .foregroundStyle(.blackDay)
                    
                    TimeSeparatorView()
                    
                    Text(formatTimeFromDate(route.arrival))
                        .frame(width: 46, height: 20)
                        .tracking(-0.41)
                        .foregroundStyle(.blackDay)
                }
                .padding(EdgeInsets(top: 2, leading: 14, bottom: 14, trailing: 14))
            }
        }
    }
    
    // MARK: - Helper Functions
    private func formatDate(_ date: String) -> String {
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
    
    private func formatTimeFromDate(_ dateString: String?) -> String {
        guard let dateString = dateString else { return "" }
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "HH:mm"
            outputFormatter.locale = Locale(identifier: "ru_RU")
            return outputFormatter.string(from: date)
        }
        
        return dateString
    }
    
    private func formatDuration(_ duration: Int) -> String {
        let hours = Int((Double(duration) / 3600).rounded())
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour]
        formatter.zeroFormattingBehavior = .dropAll
        
        let timeInterval = TimeInterval(hours * 3600)
        return formatter.string(from: timeInterval) ?? "\(hours)" + "hour"
    }
}
