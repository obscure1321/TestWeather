//
//  ForecastModel.swift
//  VKTestWeather
//
//  Created by Miras Maratov on 21.03.2024.
//

import Foundation

struct ForecastModel {
    let temperature: Int
    let dateTime: String
    let description: String
    let code: Int
    
    var conditionName: String {
        switch code {
        case 200...233:
            return "thunderStorm"
        case 300...522:
            return "showerRain"
        case 600...623:
            return "snow"
        case 700...751:
            return "mist"
        case 800...801:
            return "clearSky"
        case 802...803:
            return "fewClouds"
        case 804:
            return "brokenClouds"
        default:
            return "clouds"
        }
    }
}
