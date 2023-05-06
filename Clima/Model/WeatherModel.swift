//
//  WeatherModel.swift
//  Clima
//
//  Created by Ivan Behichev on 04.12.2022.
//

import Foundation

struct WeatherModel {
    let conditonWeatherID: Int
    let temperature: Double
    let cityName: String
    
    var temperaturyString: String {
        return String(format: "%.1f", temperature) + "°"
    }
    var conditionImageID: String {
        switch conditonWeatherID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701..<800:
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
