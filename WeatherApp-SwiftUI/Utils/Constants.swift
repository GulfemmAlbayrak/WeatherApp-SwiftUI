//
//  Constants.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 13.08.2024.
//

import Foundation

struct Constants {
    struct Urls {
        static func weatherByCity(city: String) -> URL? {
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.escaped())&appid=ff120318f7eb2ac752e37b1170425d32")
        }
        
        static func weatherUrlAsStringByIcon(icon: String) -> String {
            return "https://openweathermap.org/img/w/\(icon).png"
        }
        static func hourlyWeather(lat: Double, lon: Double) -> URL? {
            return URL(string: "https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=\(lat)&lon=\(lon)&appid=ff120318f7eb2ac752e37b1170425d32")
        }
    }
}
