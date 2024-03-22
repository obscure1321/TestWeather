//
//  MainInteractor.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 19.03.2024.
//

import Foundation

// MARK: - interactors protocol
protocol IBusinessLogic: AnyObject {
    func showData()
}

final class MainInteractor {
    // MARK: - properties
    var presenter: IPresentScreenData
    private var weatherManager = WeatherManager()
    
    // MARK: - initialization
    init(with presenter: IPresentScreenData) {
        self.presenter = presenter
        weatherManager.delegate = self
    }
    
    // MARK: - flow func
    func getData() {
        
    }
}

// MARK: - extension for WeatherManager protocol
extension MainInteractor: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        presenter.presentWeatherData(with: weather)
        print(weather)
    }
    
    func didUpdateForecast(_ weatherManager: WeatherManager, forecast: [ForecastModel]) {
        presenter.presentForecastData(with: forecast)
    }
    
    func didFailWithError(error: WeatherError) {
        print("\(error.code): \(error.localizedDescription)")
    }
}

// MARK: - extension for protocol submission
extension MainInteractor: IBusinessLogic {
    func showData() {
        print("подтягиваем данные")
        weatherManager.fetchWeather(cityName: "shymkent")
    }
}
