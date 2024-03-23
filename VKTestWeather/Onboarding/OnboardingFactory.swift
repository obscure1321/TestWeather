//
//  OnboardingFactory.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 23.03.2024.
//

import Foundation

final class OnboardingFactory: Factory {
    typealias Context = Void
    
    typealias ViewController = OnboardingViewController
    
    func build(from context: Void) -> ViewController {
        let viewController = OnboardingViewController()
        
        return viewController
    }
}
