//
//  MainViewController.swift
//  Gallery
//
//  Created by Ariuna Banzarkhanova on 11/08/24.
//

import UIKit

class MainViewController: UIViewController {
    
    private var photosViewController: PhotoViewController!
    private var videosViewController: VideoViewController!
    private var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MobileUp Gallery"
        self.view.backgroundColor = .white
        
        // Добавление кнопки выхода
        let logoutButton = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = logoutButton
        
        // Инициализация дочерних контроллеров
        photosViewController = PhotoViewController()
        videosViewController = VideoViewController()
        
        // Добавление кнопок для перехода на страницы Фото и Видео
        setupSegmentedControl()
        
        showViewController(photosViewController)
    }
    
    // Кнопка выхода
    @objc func logout() {
        // Логика выхода, например:
        self.dismiss(animated: true, completion: nil)
    }
    
    // Создание UISegmentedControl для разделов Фото и Видео
    private func setupSegmentedControl() {
        let segmentedControl = UISegmentedControl(items: ["Фото", "Видео"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
        // Добавление segmentedControl на view
        view.addSubview(segmentedControl)
        
        // Установка ограничений для размещения segmentedControl под заголовком
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        // Логика переключения между разделами
        if sender.selectedSegmentIndex == 0 {
            showViewController(photosViewController)
        } else {
            showViewController(videosViewController)
        }
    }
    
    private func showViewController(_ viewController: UIViewController) {
        // Удаление текущего дочернего контроллера, если он существует
        if let currentVC = currentViewController {
            currentVC.willMove(toParent: nil)
            currentVC.view.removeFromSuperview()
            currentVC.removeFromParent()
        }
        
        // Добавление нового дочернего контроллера
        addChild(viewController)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        
        // Установка текущего контроллера
        currentViewController = viewController
        
        // Обновление фрейма для отображения под сегментированным контролем
        updateViewControllerFrame()
    }
    
    private func updateViewControllerFrame() {
            guard let segmentedControl = view.subviews.first(where: { $0 is UISegmentedControl }) else { return }
            let yOffset = segmentedControl.frame.maxY + 8
            currentViewController?.view.frame = CGRect(x: 0, y: yOffset, width: view.bounds.width, height: view.bounds.height - yOffset)
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewControllerFrame()
    }
    
}
