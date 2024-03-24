//
//  MainInteractor.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 19.03.2024.
//

import Foundation
import CoreLocation

// MARK: - interactors protocol
protocol IBusinessLogic: AnyObject {
    func showData(with city: String)
    func reloadDataWithGeo()
}

final class MainInteractor: NSObject {
    // MARK: - properties
    var presenter: IPresentScreenData
    private var weatherManager = WeatherManager()
    private var locationManager = CLLocationManager()
    
    // MARK: - initialization
    init(with presenter: IPresentScreenData) {
        self.presenter = presenter
        super.init()
        weatherManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

// MARK: - extension for WeatherManager protocol
extension MainInteractor: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        presenter.presentWeatherData(with: weather)
    }
    
    func didUpdateForecast(_ weatherManager: WeatherManager, forecast: [ForecastModel]) {
        presenter.presentForecastData(with: forecast)
    }
    
    func didFailWithError(error: WeatherError) {
        print("\(error.code): \(error)")
    }
}

extension MainInteractor: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied:
            presenter.sendAlertInfo(with: NSLocalizedString("alertWhenGeoDenied", comment: ""))
            locationManager.requestLocation()
            break
        case .notDetermined:
            locationManager.requestLocation()
            break
        default:
            locationManager.requestLocation()
            presenter.sendAlertInfo(with: NSLocalizedString("alertWhenGeoDefault", comment: ""))
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeatherWithGeo(latitude: lat, longitude: lon)
            print("got location")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - extension for protocol submission
extension MainInteractor: IBusinessLogic {
    func showData(with city: String) {
        weatherManager.fetchWeather(cityName: city)
    }
    
    func reloadDataWithGeo() {
        locationManager.requestLocation()
    }
}
