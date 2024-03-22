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
    func didUpdateForecast(_ weatherManager: WeatherManager, forecast: [ForecastModel])
    func didFailWithError(error: WeatherError)
}

// MARK: - manager to work with api
struct WeatherManager {
    // MARK: - properties to use
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=030e8e7062f99e74dfcffdeda938f68d&units=metric"
    let forecastURL = "https://api.weatherbit.io/v2.0/forecast/daily?city=Almaty&key=205bfe2d7f224abda472c219ce5f208b"
    let responseLang = NSLocalizedString("responseLang", comment: "")
    
    var delegate: WeatherManagerDelegate?
    
    // MARK: - funcs to perform request, fetch data and parse json
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&lang=\(responseLang)&q=\(cityName)"
        getWeather(with: urlString)
        getForecast(with: forecastURL)
    }
    
    func fetchWeatherWithGeo(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        getWeather(with: urlString)
        getForecast(with: forecastURL)
    }
    
    func getWeather(with urlString: String) {
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
                    if let weather = self.parseWeatherJSON(data) {
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
    
    func getForecast(with urlString: String) {
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
                    if let forecast = self.parseForecastJSON(data) {
                        self.delegate?.didUpdateForecast(self, forecast: forecast)
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
    
    
    
    func parseWeatherJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let description = decodedData.weather[0].description
            let temp = decodedData.main.temp
            let feelsLike = decodedData.main.feelsLike
            let name = decodedData.name
            let wind = decodedData.wind.speed
            
            let weather = WeatherModel( cityName: name, conditionId: id, description: description, temperature: Int(temp), feelsLike: feelsLike, wind: Double(wind))
            return weather
            
        } catch {
            let weatherError = WeatherError(description: error.localizedDescription, code: 0)
            delegate?.didFailWithError(error: weatherError)
            return nil
        }
    }
    
//    func parseForecastJSON(_ forecastData: Data) -> ForecastModel? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(ForecastData.self, from: forecastData)
//            let datum = decodedData.data
//            let temp = datum[0].temp
//            let date = datum[0].validDate
//            let wind = datum[0].windSpd
//            
//            let weather = ForecastModel(temperature: Int(temp), wind: wind, dateTime: date)
//            return weather
//            
//        } catch {
//            let weatherError = WeatherError(description: error.localizedDescription, code: 0)
//            delegate?.didFailWithError(error: weatherError)
//            return nil
//        }
//    }
    
    func parseForecastJSON(_ forecastData: Data) -> [ForecastModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ForecastData.self, from: forecastData)
            
            var forecastModels = [ForecastModel]()
            for datum in decodedData.data {
                let weather = ForecastModel(
                    temperature: Int(datum.temp),
                    wind: datum.windSpd,
                    dateTime: datum.validDate
                )
                forecastModels.append(weather)
            }
            
            return forecastModels
            
        } catch let error {
            print("Decoding error:", error)
            let weatherError = WeatherError(description: error.localizedDescription, code: 0)
            delegate?.didFailWithError(error: weatherError)
            return nil
        }
    }

}
