//
//  RouterExtensions.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 19.03.2024.
//

import Foundation

extension Router {
    static func onboardingScreen() {
        performRoute(factory: OnboardingFactory(), context: ())
    }
    
    static func mainModuleScreen() {
        performRoute(factory: MainModuleFactory(), context: ())
        navigationController.viewControllers.last?.navigationItem.setHidesBackButton(true, animated: false)
    }
}
