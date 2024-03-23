//
//  Router.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 19.03.2024.
//

import UIKit

public final class Router {
    static let navigationController = UINavigationController()
    private init() {}
}

public extension Router {
    static func startRouting() -> UINavigationController {
        return navigationController
    }
    
    static func performRoute<F>(factory: F, context: F.Context, animated: Bool = true) where F: Factory, F.ViewController: UIViewController {
        let viewController = factory.build(from: context)
        
        navigationController.pushViewController(viewController, animated: animated)
    }
}
