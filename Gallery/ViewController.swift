//
//  ViewController.swift
//  Gallery
//
//  Created by Ariuna Banzarkhanova on 10/08/24.
//

import UIKit

class ViewController: UIViewController {
    var label = UILabel()
    var logInButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        buildView()
    }
    
    func buildView() {
        buildLogInButton()
        buildLabel()
    }
    
    func buildLogInButton() {
        logInButton.setTitle("Вход через VK", for: .normal)
        logInButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        logInButton.layer.cornerRadius = 12
        logInButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)

        // Enable Auto Layout
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(logInButton)

        // Set constraints
        NSLayoutConstraint.activate([
            logInButton.heightAnchor.constraint(equalToConstant: 52),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    func buildLabel() {
        label.text = """
        Mobile Up
        Gallery
        """
        label.font = .systemFont(ofSize: 44, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2

        // Enable Auto Layout
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)

        // Set constraints
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 160)
        ])
    }
    
    @objc func logInButtonPressed() {
        
    }
}

