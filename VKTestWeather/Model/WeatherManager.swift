//
//  WeatherManager.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 20.03.2024.
//

import Foundation
import CoreLocation

// MARK: - protocol to delegate
protocol WeatherManagerDelegate: AnyObject {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didUpdateForecast(_ weatherManager: WeatherManager, forecast: [ForecastModel])
    func didFailWithError(error: WeatherError)
}

// MARK: - manager to work with api
final class WeatherManager {
    // MARK: - properties to use
    var delegate: WeatherManagerDelegate?
    
    enum Constants {
        static let scheme = "https"
        static let weatherHost = "api.openweathermap.org"
        static let weatherPath = "/data/2.5/weather"
        static let weatherAPIKey = "030e8e7062f99e74dfcffdeda938f68d"
        
        static let forecastHost = "api.weatherbit.io"
        static let forecastPath = "/v2.0/forecast/daily"
        static let forecastAPIKey = "47edaf305fac4323a57a568bee475cb4"
    }
    
    // MARK: - funcs to perform request, fetch data and parse json
    private func buildURL(
        host: String,
        path: String,
        appid: String? = nil,
        key: String? = nil,
        queryCity: String? = nil,
        city: String? = nil,
        lat: String? = nil,
        lon: String? = nil) -> URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = host
        components.path = path
        
        let queryItems: [URLQueryItem] = [
            appid.map { URLQueryItem(name: "appid", value: $0) },
            key.map { URLQueryItem(name: "key", value: $0) },
            city.map { URLQueryItem(name: queryCity ?? "" , value: $0) },
            lat.map { URLQueryItem(name: "lat", value: $0) },
            lon.map { URLQueryItem(name: "lon", value: $0) },
            URLQueryItem(name: "lang", value: NSLocalizedString("responseLang", comment: "")),
            URLQueryItem(name: "units", value: "metric")
        ]
        .compactMap { $0 }
        
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        
        return components.url
    }
    
    func fetchWeather(cityName: String) {
        getWeather(with: buildURL(
            host: Constants.weatherHost,
            path: Constants.weatherPath,
            appid: Constants.weatherAPIKey,
            queryCity: "q",
            city: cityName
        ))
        
        getForecast(with: buildURL(
            host: Constants.forecastHost,
            path: Constants.forecastPath,
            key: Constants.forecastAPIKey,
            queryCity: "city",
            city: cityName
        ))
    }
    
    func fetchWeatherWithGeo(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        getWeather(with: buildURL(
            host: Constants.weatherHost,
            path: Constants.weatherPath,
            appid: Constants.weatherAPIKey,
            lat: String(latitude),
            lon: String(longitude)
        ))
        
        getForecast(with: buildURL(
            host: Constants.forecastHost,
            path: Constants.forecastPath,
            key: Constants.forecastAPIKey,
            lat: String(latitude),
            lon: String(longitude)
        ))
    }
    
    func getWeather(with url: URL?) {
        guard let url = url else {
            print("Invalid URL: URL is nil")
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
    
    func getForecast(with url: URL?) {
        guard let url = url else {
            print("Invalid URL: URL is nil")
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
    
    // MARK: - funcs to parse the data
    func parseWeatherJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let description = decodedData.weather[0].description
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(
                cityName: name, 
                id: id,
                description: description,
                temperature: Int(temp))
            
            return weather
            
        } catch {
            let weatherError = WeatherError(description: error.localizedDescription, code: 0)
            delegate?.didFailWithError(error: weatherError)
            return nil
        }
    }
    
    func parseForecastJSON(_ forecastData: Data) -> [ForecastModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ForecastData.self, from: forecastData)
            
            var forecastModels = [ForecastModel]()
            for datum in decodedData.data {
                let weather = ForecastModel(
                    temperature: Int(datum.temp),
                    dateTime: datum.validDate,
                    description: datum.weather.description, 
                    code: datum.weather.code
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
