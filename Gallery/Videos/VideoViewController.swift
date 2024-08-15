//
//  VideoViewController.swift
//  Gallery
//
//  Created by Ariuna Banzarkhanova on 11/08/24.
//

import UIKit

class VideoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Видео"
        self.view.backgroundColor = .white
        
        // Создание и настройка UICollectionView
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.width / 2)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "VideoCell")
        self.view.addSubview(collectionView)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // Примерное количество видео
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath)
        cell.backgroundColor = .darkGray // Тут будет отображение превью видео
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoDetailViewController = VideoDetailViewController()
        navigationController?.pushViewController(videoDetailViewController, animated: true)
    }
    
}
