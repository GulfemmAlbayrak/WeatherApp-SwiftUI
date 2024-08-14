//
//  HourlyWeatherResponse.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 13.08.2024.
//

import Foundation

struct HourlyWeatherResponse: Decodable {
    let list: [HourlyWeather]
}

struct HourlyWeather: Decodable, Identifiable {
    let id = UUID()
    let dt: Date
    let temperature: Double
    let icon: String
    
    private enum CodingKeys: String, CodingKey {
        case dt
        case temperature = "temp"
        case weather
    }
    
    private enum WeatherKeys: String, CodingKey {
        case temperature = "temp"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dt = try container.decode(Date.self, forKey: .dt)
        
        let mainContainer = try container.nestedContainer(keyedBy: WeatherKeys.self, forKey: .weather)
        temperature = try mainContainer.decode(Double.self, forKey: .temperature)
        
        let weatherContainer = try container.decode([WeatherIcon].self, forKey: .weather)
        icon = weatherContainer.first!.icon
    }
}
