//
//  CopyrightWebView.swift
//  Travel_schedule
//
//  Created by Irina Muravyeva on 13.07.2026.
//

import SwiftUI
import WebKit

struct CopyrightWebView: UIViewRepresentable {
    let url: URL
    let isDarkMode: Bool
    
    @Binding var isLoading: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        
        let webView = WKWebView(
            frame: .zero,
            configuration: configuration
        )
        webView.isOpaque = false
        webView.navigationDelegate = context.coordinator
        
        return webView
    }
    
    func updateUIView(
        _ webView: WKWebView,
        context: Context
    ) {
        let themeScript = """
            document.documentElement.style.colorScheme = '\(isDarkMode ? "dark" : "light")';
            """
        webView.evaluateJavaScript(themeScript)
        
        if webView.url != url {
            DispatchQueue.main.async {
                isLoading = true
            }
            
            webView.load(
                URLRequest(url: url)
            )
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: CopyrightWebView
        
        init(_ parent: CopyrightWebView) {
            self.parent = parent
        }
        
        func webView(
            _ webView: WKWebView,
            didFinish navigation: WKNavigation?
        ) {
            finishLoading()
        }
        
        func webView(
            _ webView: WKWebView,
            didFail navigation: WKNavigation?,
            withError error: Error
        ) {
            finishLoading()
        }
        
        func webView(
            _ webView: WKWebView,
            didFailProvisionalNavigation navigation: WKNavigation?,
            withError error: Error
        ) {
            finishLoading()
        }
        
        private func finishLoading() {
            DispatchQueue.main.async {
                self.parent.isLoading = false
            }
        }
    }
}
