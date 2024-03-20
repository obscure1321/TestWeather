//
//  MainPresenter.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 19.03.2024.
//

import Foundation
// MARK: - presenters protocol
protocol IPresentScreenData: AnyObject {
    func presentScreenData(with  viewModel: WeatherModel)
}

final class MainPresenter {
    // MARK: - properties
    weak var viewController: IDisplayServiceData?
    
    //MARK: - initialization
    init(viewController: IDisplayServiceData? = nil) {
        self.viewController = viewController
    }
}

// MARK: - extension for protocol submission
extension MainPresenter: IPresentScreenData {
    func presentScreenData(with viewModel: WeatherModel) {
        print("здесь будет код для передачи данных в vc")
        viewController?.displayServiceData(with: viewModel)
    }
}
