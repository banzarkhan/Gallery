//
//  LoginView.swift
//  Gallery
//
//  Created by Ariuna Banzarkhanova on 14/08/24.
//

import Foundation
import UIKit
import SwiftUI
import WebKit

struct LoginView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "oauth.vk.com"
        urlComponent.path = "/authorize"
        
        urlComponent.queryItems = [
        URLQueryItem(name: "client_id", value: "52142397"),
        URLQueryItem(name: "redirect_uri", value: "http://oauth.vk.com/blank.html"),
        URLQueryItem (name: "display", value: "mobile"),
        URLQueryItem(name: "response_type", value: "token")]
        
        let req = URLRequest(url: urlComponent.url!)
        webView.load(req)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
//
    }
    
    
}
