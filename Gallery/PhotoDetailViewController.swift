//
//  PhotoDetailViewController.swift
//  Gallery
//
//  Created by Ariuna Banzarkhanova on 11/08/24.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // Настройка UI для отображения фото и даты загрузки
        self.title = "Дата загрузки"
        
        // Добавление Share-меню
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePhoto))
        self.navigationItem.rightBarButtonItem = shareButton
    }
    
    @objc func sharePhoto() {
        // Логика для Share-меню
        let activityViewController = UIActivityViewController(activityItems: ["Фото для шаринга"], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
