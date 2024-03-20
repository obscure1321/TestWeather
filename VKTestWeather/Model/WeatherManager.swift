//
//  WeatherManager.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 20.03.2024.
//

import Foundation
import CoreLocation

// MARK: - protocol to delegate
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: WeatherError)
}

// MARK: - manager to work with api
struct WeatherManager {
    // MARK: - properties to use
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=030e8e7062f99e74dfcffdeda938f68d&units=metric"
    let responseLang = NSLocalizedString("responseLang", comment: "")
    
    var delegate: WeatherManagerDelegate?
    
    // MARK: - funcs to perform request, fetch data and parse json
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&lang=\(responseLang)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeatherWithGeo(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            switch (data, response, error) {
            case (_, _, let error?):
                print("Error: \(error.localizedDescription)")
                let weatherError = WeatherError(description: error.localizedDescription, code: 0)
                self.delegate?.didFailWithError(error: weatherError)
                
            case (let data?, let response as HTTPURLResponse, _):
                switch response.statusCode {
                case 200...299:
                    if let weather = self.parseJSON(data) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                default:
                    let errorDescription = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                    let weatherError = WeatherError(description: errorDescription, code: response.statusCode)
                    self.delegate?.didFailWithError(error: weatherError)
                }
                
            default:
                print("Unexpected response: \(response.debugDescription)")
            }
        }
        task.resume()
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let description = decodedData.weather[0].description
            let temp = decodedData.main.temp
            let feelsLike = decodedData.main.feelsLike
            let name = decodedData.name
            let wind = decodedData.wind.speed
            
            let weather = WeatherModel( cityName: name, conditionId: id, description: description, temperature: temp, feelsLike: feelsLike, wind: wind)
            return weather
            
        } catch {
            let weatherError = WeatherError(description: error.localizedDescription, code: 0)
            delegate?.didFailWithError(error: weatherError)
            return nil
        }
    }
}
