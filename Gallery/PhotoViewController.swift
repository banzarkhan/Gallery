//
//  PhotoViewController.swift
//  Gallery
//
//  Created by Ariuna Banzarkhanova on 11/08/24.
//

import UIKit

class PhotoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    
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
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // Примерное количество фотографий
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        cell.backgroundColor = .gray // Тут будет отображение фото
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoDetailViewController = PhotoDetailViewController()
        navigationController?.pushViewController(photoDetailViewController, animated: true)
    }
    
}
