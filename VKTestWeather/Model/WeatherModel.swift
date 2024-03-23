//
//  WeatherModel.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 20.03.2024.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let id: Int
    let description: String
    let temperature: Int
    let feelsLike: Double
    let wind: Double
    
    var conditionName: String {
        switch id {
        case 200...232:
            return "thunderStorm"
        case 300...321:
            return "showerRain"
        case 500...504:
            return "rain"
        case 511:
            return "snow"
        case 520...531:
            return "showerRain"
        case 600...622:
            return "snow"
        case 701...781:
            return "mist"
        case 800:
            return "clearSky"
        case 801:
            return "fewClouds"
        case 802:
            return "clouds"
        case 803...804:
            return "brokenClouds"
        default:
            return "clouds"
        }
    }
}
