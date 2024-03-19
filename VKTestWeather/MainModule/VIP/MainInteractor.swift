//
//  MainInteractor.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 19.03.2024.
//

import Foundation

protocol IBusinessLogic: AnyObject {
    func showData()
}

final class MainInteractor {
    var presenter: IPresentScreenData
    
    init(with presenter: IPresentScreenData) {
        self.presenter = presenter
    }
}

extension MainInteractor: IBusinessLogic {
    func showData() {
        
    }
}
