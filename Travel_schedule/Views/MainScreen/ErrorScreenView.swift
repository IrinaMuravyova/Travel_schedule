//
//  ErrorScreenView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 29.06.2026.
//

import SwiftUI

enum NetworkError {
    case serverNotAllow
    case connectionError
}

struct ErrorScreenView: View {
    let error: NetworkError?
    
    var body: some View {
        switch error {
        case .serverNotAllow:
            ErrorView(image: .serverError, text: "Server error")
        case .connectionError:
            ErrorView(image: .noInternet, text: "No internet")
        default:
            Text("Unknown error")
        }
    }
}
