//
//  CloseButton.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 13.07.2026.
//

import SwiftUI

struct CloseButton: View {
    let action: () -> Void
    
    var body: some View {
        Button{
            action()
        } label: {
            Image(.close)
                .resizable()
                .frame(width: 20, height: 20)
        }
        .frame(width: 40, height: 40)
    }
}
