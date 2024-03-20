//
//  WeatherError.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 20.03.2024.
//

import Foundation

struct WeatherError: Error {
    let description: String
    let code: Int
}
