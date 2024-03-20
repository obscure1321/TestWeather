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
    private var weatherManager = WeatherManager()
    
    init(with presenter: IPresentScreenData) {
        self.presenter = presenter
        weatherManager.delegate = self
    }
    
    func getData() {
        weatherManager.fetchWeather(cityName: "шымкент")
        self.presenter.presentScreenData()
    }
}

extension MainInteractor: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        print(weather)
    }
    
    func didFailWithError(error: WeatherError) {
        print("\(error.code): \(error.localizedDescription)")
    }
}

extension MainInteractor: IBusinessLogic {
    func showData() {
        print("подтягиваем данные")
        getData()
    }
}
