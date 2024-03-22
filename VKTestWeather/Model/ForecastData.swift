//
//  ForecastData.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 21.03.2024.
//

import Foundation

struct ForecastData: Codable {
    let city_name, country_code: String
    let data: [Datum]
    let lat, lon, state_code, timezone: String
}

struct Datum: Codable {
    let clouds: Int
    let maxTemp: Double
    let minTemp: Double
    let temp: Double
    let validDate: String
    let windSpd: Double
    
    enum CodingKeys: String, CodingKey {
        case clouds
        case maxTemp = "max_temp"
        case minTemp = "min_temp"
        case temp
        case validDate = "valid_date"
        case windSpd = "wind_spd"
    }
}
