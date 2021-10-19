//
//  TabBarController.swift
//  App of Holding v1
//
//  Created by Richard Centeno on 10/16/21.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    let button = UIButton.init(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        button.setTitle("+", for: .normal)
//        button.setTitleColor(.systemGreen, for: .normal)
//        button.setTitleColor(.systemPink, for: .highlighted)
//        button.frame = CGRect(x: 100, y: 0, width: 44, height: 44)
//        button.backgroundColor = .blue
//        button.layer.borderWidth = 4
//        button.layer.borderColor = UIColor.blue.cgColor
//        self.view.insertSubview(button, aboveSubview: self.tabBar)
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        button.frame = CGRect.init(x: self.tabBar.center.x - 32, y: self.view.bounds.height - 74, width: 64, height: 64)
//        button.layer.cornerRadius = 32
    }
}
