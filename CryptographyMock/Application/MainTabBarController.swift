//
//  MainTabBarController.swift
//  CryptographyMock
//
//  Created by JunHyeok Lee on 2023/04/24.
//

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.Color.background
        configureTab()
    }
    
    private func configureTab() {
        let cryptoTab = UINavigationController(rootViewController: CryptographyViewController())
        cryptoTab.tabBarItem = UITabBarItem(title: "Crypto", image: nil, selectedImage: nil)
        
        let cryptoSwiftTab = UINavigationController(rootViewController: CryptoSwiftViewController())
        cryptoSwiftTab.tabBarItem = UITabBarItem(title: "CryptoSwift", image: nil, selectedImage: nil)
        
        viewControllers = [
            cryptoTab,
            cryptoSwiftTab,
        ]
    }
}
