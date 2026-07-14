//
//  ContactInfoView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 14.07.2026.
//

import SwiftUI

struct ContactInfoView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let title: String
    let details: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 17))
                .tracking(-0.41)
                .foregroundStyle(colorScheme == .dark ? .white : .blackDay)
            Text(details)
                .font(.system(size: 12))
                .tracking(0.4)
                .foregroundStyle(.blueUniversal)
        }
        .frame(height: 60)
    }
}

#Preview {
    ContactInfoView(title: "E-mail", details: "i.lozgkina@yandex.ru")
}
