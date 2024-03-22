//
//  WeatherModel.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 20.03.2024.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let conditionId: Int
    let description: String
    let temperature: Int
    let feelsLike: Double
    let wind: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
