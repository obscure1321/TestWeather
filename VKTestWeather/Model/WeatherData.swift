//
//  WeatherData.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 20.03.2024.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

struct Weather: Codable {
    let description: String
    let id: Int
}

struct Wind: Codable {
    let speed, deg: Int
}
