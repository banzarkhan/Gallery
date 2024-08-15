//
//  PhotoDetailViewController.swift
//  Gallery
//
//  Created by Ariuna Banzarkhanova on 11/08/24.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        // Настройка UI для отображения фото и даты загрузки
        self.title = "Дата загрузки"
        
        if let image = image {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = self.view.bounds
            self.view.addSubview(imageView)
        }
        
        // Добавление Share-меню
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePhoto))
        self.navigationItem.rightBarButtonItem = shareButton
    }
    
    @objc func sharePhoto() {
        guard let image = image else { return }
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
