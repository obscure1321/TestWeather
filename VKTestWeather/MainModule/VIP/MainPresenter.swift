//
//  MainPresenter.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 19.03.2024.
//

import Foundation

protocol IPresentScreenData: AnyObject {
    func presentScreenData()
}

final class MainPresenter {
    weak var viewController: IDisplayServiceData?
    
    init(viewController: IDisplayServiceData? = nil) {
        self.viewController = viewController
    }
}

extension MainPresenter: IPresentScreenData {
    func presentScreenData() {
        
    }
}
