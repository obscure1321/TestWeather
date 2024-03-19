//
//  MainModuleFactory.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 19.03.2024.
//

import Foundation

final class MainModuleFactory: Factory {
    typealias Context = Void
    
    typealias ViewController = MainViewController
    
    func build(from context: Void) -> MainViewController {
        let presenter = MainPresenter()
        let interactor = MainInteractor(with: presenter)
        let viewController = MainViewController(with: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
