//
//  VideoViewController.swift
//  Gallery
//
//  Created by Ariuna Banzarkhanova on 11/08/24.
//

import UIKit

class VideoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var collectionView: UICollectionView!
    private var videos: [Video] = []
    private let networkManager = NetworkManager()
    
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
        
        loadVideos()
    }
    
    private func loadVideos() {
        Task {
            let result = await networkManager.getVideosURL(token: UserDefaults.standard.string(forKey: "authToken") ?? "")
            switch result {
            case .success(let videos):
                self.videos = videos
                self.collectionView.reloadData()
            case .failure(let error):
                print("Error loading videos: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count // Примерное количество видео
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath)
        cell.backgroundColor = .darkGray
        let video = videos[indexPath.item]
        if let imageUrl = video.image.first?.url {
            let imageView = UIImageView(frame: cell.contentView.bounds)
            
            // Загрузить изображение из imageUrl
            // imageView.image = ...
            cell.contentView.addSubview(imageView)
            
            Task {
                do {
                    if let url = URL(string: imageUrl) {
                        let (data, _) = try await URLSession.shared.data(from: url)
                        if let image = UIImage(data: data) {
                            imageView.image = image
                        }
                    }
                } catch {
                    print("Error loading image: \(error.localizedDescription)")
                }
            }
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = videos[indexPath.item]
        let videoDetailViewController = VideoDetailViewController()
        videoDetailViewController.videoURL = video.player
        videoDetailViewController.videoTitle = video.title
        navigationController?.pushViewController(videoDetailViewController, animated: true)
    }
    
}
