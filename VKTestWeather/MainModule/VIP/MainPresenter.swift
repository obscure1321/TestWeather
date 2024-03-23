//
//  MainPresenter.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 19.03.2024.
//

import Foundation
// MARK: - presenters protocol
protocol IPresentScreenData: AnyObject {
    func presentWeatherData(with viewModel: WeatherModel)
    func presentForecastData(with viewModel: [ForecastModel])
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
    func presentWeatherData(with viewModel: WeatherModel) {
        viewController?.displayWeatherData(with: viewModel)
    }
    
    func presentForecastData(with viewModels: [ForecastModel]) {
        viewController?.displayForecastData(with: viewModels)
    }
}
