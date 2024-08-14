//
//  WeatherIcon.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 14.08.2024.
//

import SwiftUI

enum WeatherIcon: String {
    case clearDay = "sun.max"
    case clearNight = "moon.stars"
    case fewCloudsDay = "cloud.sun.fill"
    case fewCloudsNight = "cloud.moon.fill"
    case brokenClouds = "cloud"      
    case scatteredClouds = "cloud.fill"
    case showerRain = "cloud.drizzle.fill"
    case rain = "cloud.rain.fill"
    case thunderstorm = "cloud.bolt.rain.fill"
    case snow = "snow"
    case mist = "cloud.fog.fill"
    
    var systemName: String {
        return self.rawValue
    }
    
    static func icon(for weatherCode: String) -> WeatherIcon {
        switch weatherCode {
        case "01d": return .clearDay
        case "01n": return .clearNight
        case "02d": return .fewCloudsDay
        case "02n": return .fewCloudsNight
        case "03d", "03n": return .scatteredClouds
        case "04d", "04n": return .brokenClouds
        case "09d", "09n": return .showerRain
        case "10d": return .rain
        case "10n": return .rain
        case "11d", "11n": return .thunderstorm
        case "13d", "13n": return .snow
        case "50d", "50n": return .mist
        default: return .clearDay
        }
    }
}

