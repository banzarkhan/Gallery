//
//  LoginView.swift
//  Gallery
//
//  Created by Ariuna Banzarkhanova on 14/08/24.
//

import UIKit
import WebKit

class LoginViewController: UIViewController, WKNavigationDelegate {
    
    var tokenHandler: ((String) -> Void)?
    var token: String = ""
    
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        loadAuthorizationRequest()
    }
    
    private func setupWebView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func loadAuthorizationRequest() {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "oauth.vk.com"
        urlComponent.path = "/authorize"
        
        urlComponent.queryItems = [
            URLQueryItem(name: "client_id", value: "52142397"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "response_type", value: "token")
        ]
        
        if let url = urlComponent.url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    // MARK: - WKNavigationDelegate Methods
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        if let url = navigationResponse.response.url?.absoluteString {
            if url.contains("access_token=") {
                if let token = extractToken(from: url) {
                    self.token = token
                    
                    UserDefaults.standard.set(token, forKey: "authToken")
                    
                    tokenHandler?(token)
                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                        sceneDelegate.switchToMainViewController()
                    }
                    dismiss(animated: true, completion: nil)
                }
            }
        }
        decisionHandler(.allow)
    }
    
    private func extractToken(from url: String) -> String? {
        let components = URLComponents(string: url)
        return components?.fragment?
            .components(separatedBy: "&")
            .first { $0.contains("access_token=") }?
            .replacingOccurrences(of: "access_token=", with: "")
    }
}

