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
    func sendAlertInfo(with info: String)
}

final class MainPresenter {
    // MARK: - properties
    private var weatherData: WeatherModel?
    private var forecastData: [ForecastModel]?
    weak var viewController: IDisplayServiceData?
    
    private let dispatchGroup = DispatchGroup()
    
    // MARK: - initialization
    init(viewController: IDisplayServiceData? = nil) {
        self.viewController = viewController
    }
}

// MARK: - extension for protocol submission
extension MainPresenter: IPresentScreenData {
    func presentWeatherData(with viewModel: WeatherModel) {
        dispatchGroup.enter()
        weatherData = viewModel
        checkAndUpdateUI()
    }
    
    func presentForecastData(with viewModels: [ForecastModel]) {
        dispatchGroup.enter()
        forecastData = viewModels
        checkAndUpdateUI()
    }
    
    func sendAlertInfo(with info: String) {
        viewController?.showAlert(with: info)
    }
}

extension MainPresenter {
    private func checkAndUpdateUI() {
        dispatchGroup.leave()
        dispatchGroup.notify(queue: .main) {
            guard let weather = self.weatherData, let forecast = self.forecastData else {
                print("no data yet")
                return
            }
            self.viewController?.displayWeatherData(with: weather)
            self.viewController?.displayForecastData(with: forecast)
        }
    }
}
