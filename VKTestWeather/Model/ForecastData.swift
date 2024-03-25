//
//  ForecastData.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 21.03.2024.
//

import Foundation

struct ForecastData: Codable {
    let data: [Datum]
}

struct Datum: Codable {
    let temp: Double
    let validDate: String
    let weather: Forecast
    
    enum CodingKeys: String, CodingKey {
        case temp
        case validDate = "valid_date"
        case weather
    }
}

struct Forecast: Codable {
    let code: Int
    let description: String
}
