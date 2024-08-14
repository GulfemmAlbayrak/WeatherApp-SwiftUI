//
//  WeatherViewModel.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 13.08.2024.
//

import Foundation

struct WeatherViewModel {
    let weather: Weather
    let id = UUID()
    
    func getTemperatureByUnit(unit: TemperatureUnit) -> Double {
        switch unit {
        case .kelvin:
            return weather.main.temp
        case .celsius:
            return weather.main.temp - 273.15
        case .fahrenheit:
            return 1.8 * (weather.main.temp - 273.15) + 32
        }
    }
    var name: String {
        return weather.name
    }
    var dt: Int {
        return weather.dt
    }
    var temperature: Double {
        return weather.main.temp
    } 
    var main: Main {
        return weather.main
    }
    var wind: Wind {
        return weather.wind
    }
    var sys: Sys {
        return weather.sys
    }
    var coord: Coord {
        return weather.coord
    }
    
    var city: String {
        return weather.name
    }
    
    var icon: String {
        return weather.weather.first?.icon ?? "01d" // Fallback icon
    }
    
    var sunset: Date {
        return Date(timeIntervalSince1970: TimeInterval(weather.sys.sunset))
    }
    
    var sunrise: Date {
        return Date(timeIntervalSince1970: TimeInterval(weather.sys.sunrise))
    }
    
    var humidity: Int {
        return weather.main.humidity
    }
}
