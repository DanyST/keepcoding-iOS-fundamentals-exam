//
//  SceneDelegate.swift
//  SuperHeroes
//
//  Created by Luis Herrera Lillo on 30-09-23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let loginViewController = LoginViewController()
        let navigation = UINavigationController(rootViewController: loginViewController)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        self.window = window
    }
}

