//
//  SceneDelegate.swift
//  CryptographyMock
//
//  Created by JunHyeok Lee on 2023/04/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        let rootViewController = MainTabBarController()
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }

}

