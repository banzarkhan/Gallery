//
//  VideoDetailViewController.swift
//  Gallery
//
//  Created by Ariuna Banzarkhanova on 11/08/24.
//

import UIKit
import WebKit

class VideoDetailViewController: UIViewController {
    
    var videoURL: String?
    var videoTitle: String?

    private var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // Настройка UI для отображения видео и названия видео
        self.title = videoTitle
        
        // Добавление Share-меню
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareLink))
        self.navigationItem.rightBarButtonItem = shareButton
        
        // Настройка WebView для видео
        webView = WKWebView(frame: self.view.bounds)
        if let url = URL(string: videoURL ?? "") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        self.view.addSubview(webView)
    }

    @objc func shareLink() {
        
        let activityViewController = UIActivityViewController(activityItems: [videoURL ?? ""], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
}
