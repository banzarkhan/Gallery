//
//  PhotoViewController.swift
//  Gallery
//
//  Created by Ariuna Banzarkhanova on 11/08/24.
//

import UIKit

class PhotoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    private var photos: [UIImage?] = [] // Массив для хранения фотографий
    private let networkManager = NetworkManager() // Экземпляр NetworkManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Фото"
        self.view.backgroundColor = .white
        
        // Создание и настройка UICollectionView
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width / 2 - 10, height: view.frame.width / 2 - 10)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        self.view.addSubview(collectionView)
        
        Task {
            await loadPhotos()
        }
    }
    
    private func loadPhotos() async {
        let token = UserDefaults.standard.string(forKey: "authToken") ?? "" // Используйте ваш токен
        
        switch await networkManager.getImagesURL(token: token) {
        case .success(let photoItems):
            // Загружаем изображения по URL
            self.photos = await loadImages(photoItems: photoItems)
            self.collectionView.reloadData()
        case .failure(let error):
            print("Error loading images: \(error.localizedDescription)")
        }
    }
    
    private func loadImages(photoItems: [Photo]) async -> [UIImage?] {
        return await withTaskGroup(of: UIImage?.self) { group in
            for item in photoItems {
                if let urlString = item.sizes.last?.url, let url = URL(string: urlString) {
                    group.addTask {
                        return await self.networkManager.loadImage(from: url)
                    }
                } else {
                    group.addTask {
                        return nil
                    }
                }
            }
            
            var images: [UIImage?] = []
            for await image in group {
                images.append(image)
            }
            return images
        }
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        let imageView = UIImageView(image: photos[indexPath.item])
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        cell.contentView.addSubview(imageView)
        imageView.frame = cell.contentView.frame
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoDetailViewController = PhotoDetailViewController()
        photoDetailViewController.image = photos[indexPath.item]
        navigationController?.pushViewController(photoDetailViewController, animated: true)
    }
    
}
