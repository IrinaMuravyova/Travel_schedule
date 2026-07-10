//
//  SVGImage.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 03.07.2026.
//

import SwiftUI
import WebKit

struct SVGImage: View {
    let url: String?
    @State private var svg: String = ""
    @State private var isLoading = true
    
    var body: some View {
        Group {
            if isLoading {
                Color.gray.opacity(0.3)
                    .frame(width: 38, height: 38)
                    .cornerRadius(12)
            } else if !svg.isEmpty {
                WebView(html: svg)
                    .frame(width: 38, height: 38)
                    .cornerRadius(12)
            } else {
                Color.gray.opacity(0.3)
                    .frame(width: 38, height: 38)
                    .cornerRadius(12)
            }
        }
        .onAppear {
            loadSVG()
        }
    }
    
    func loadSVG() {
        guard let urlString = url,
              let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        guard svg.isEmpty else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                isLoading = false
                if let data = data,
                   let string = String(data: data, encoding: .utf8) {
                    svg = string
                }
            }
        }.resume()
    }
}

struct WebView: UIViewRepresentable {
    let html: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.backgroundColor = .clear
        webView.isOpaque = false
        webView.scrollView.isScrollEnabled = false
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.loadHTMLString("""
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                body { 
                    margin: 0; 
                    padding: 0; 
                    display: flex; 
                    justify-content: center; 
                    align-items: center; 
                    height: 100vh;
                    background: transparent;
                }
                svg { width: 100%; height: 100%; max-width: 38px; max-height: 38px; }
            </style>
        </head>
        <body>\(html)</body>
        </html>
        """, baseURL: nil)
    }
}
