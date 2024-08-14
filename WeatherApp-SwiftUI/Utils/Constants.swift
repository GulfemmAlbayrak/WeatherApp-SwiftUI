//
//  Constants.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 13.08.2024.
//

import Foundation

struct Constants {
    
    static let apiKey = "ff120318f7eb2ac752e37b1170425d32"

    struct Urls {
        static func weatherByCity(city: String) -> URL? {
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.escaped())&appid=\(Constants.apiKey)")
        }
        
        static func weatherUrlAsStringByIcon(icon: String) -> String {
            return "https://openweathermap.org/img/w/\(icon).png"
        }

        static func forecastByCoordinates(lat: Double, lon: Double) -> URL? {
            return URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(Constants.apiKey)")
        }
    }
    struct Icons {
        static func weatherIcon(for weatherCode: String) -> String {
            return WeatherIcon.icon(for: weatherCode).systemName
        }
    }
}
