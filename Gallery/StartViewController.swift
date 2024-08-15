//
//  StartViewController.swift
//  Gallery
//
//  Created by Ariuna Banzarkhanova on 10/08/24.
//

import UIKit

class StartViewController: UIViewController {
    var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        buildLabel()
    }
    
    func buildLabel() {
        // Auto layout, variables, and unit scale are not yet supported
        label.frame = CGRect(x: 0, y: 0, width: 227, height: 106)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "SFProText-Bold", size: 44)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        // Line height: 52.51 pt
        label.attributedText = NSMutableAttributedString(string: "Mobile Up  Gallery", attributes: [NSAttributedString.Key.kern: -0.66])

        self.view.addSubview(label)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 227).isActive = true
        view.heightAnchor.constraint(equalToConstant: 106).isActive = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
