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
        print("здесь будет код для передачи данных в vc")
        viewController?.displayServiceData(with: viewModel)
    }
    
    func presentForecastData(with viewModel: [ForecastModel]) {
        print("здесь будет код для передачи данных в vc")
        print(viewModel)
    }
}
