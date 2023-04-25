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
        let cryptoSwiftTab = UINavigationController(rootViewController: CryptoSwiftViewController())
        cryptoSwiftTab.tabBarItem = UITabBarItem(title: "CryptoSwift", image: nil, selectedImage: nil)
        
        let cryptoTab = UINavigationController(rootViewController: CryptographyViewController())
        cryptoTab.tabBarItem = UITabBarItem(title: "Crypto", image: nil, selectedImage: nil)
        
        let cryptoFrameworkTab = UINavigationController(rootViewController: CryptoFrameworkViewController())
        cryptoFrameworkTab.tabBarItem = UITabBarItem(title: "CryptoFramework", image: nil, selectedImage: nil)
        
        let cryptoTestTab = UINavigationController(rootViewController: CryptoTestViewController())
        cryptoTestTab.tabBarItem = UITabBarItem(title: "CryptoTest", image: nil, selectedImage: nil)
        
        let cryptographyTestTab = UINavigationController(rootViewController: CryptographyTestViewController())
        cryptographyTestTab.tabBarItem = UITabBarItem(title: "Custom", image: nil, selectedImage: nil)
        
        viewControllers = [
            cryptoSwiftTab,
            cryptoTab,
            cryptoFrameworkTab,
            cryptoTestTab,
            cryptographyTestTab,
        ]
    }
}
