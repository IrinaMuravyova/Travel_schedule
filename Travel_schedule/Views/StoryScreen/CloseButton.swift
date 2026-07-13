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
        Button("", image: .close) {
            action()
        }
    }
}
