//
//  CopyrightLoader.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 15.06.2026.
//

import Foundation

final class CopyrightLoader {
    private let networkClient: NetworkClient
    private var cachedCopyright: CopyrightInfo?
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getCopyright(format: String? = nil) async throws -> CopyrightInfo {
        if let cachedCopyright {
            return cachedCopyright
        }
        
        let copyright = try await networkClient.fetchCopyright()
        
        cachedCopyright = copyright
        
        return copyright
    }
}
