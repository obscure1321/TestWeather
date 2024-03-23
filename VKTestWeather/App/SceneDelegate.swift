//
//  SceneDelegate.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 19.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let isOnboarded = UserDefaults.standard.bool(forKey: "onboarded")
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = Router.startRouting()
        
        if isOnboarded {
            Router.mainModuleScreen()
        } else {
            Router.onboardingScreen()
        }
        
        window?.makeKeyAndVisible()
    }
}

