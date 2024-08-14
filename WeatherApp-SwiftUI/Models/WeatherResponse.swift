//
//  WeatherResponse.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 13.08.2024.
//

import Foundation

struct WeatherResponse: Decodable {
    let name: String
    var weather: Weather
    let icon: [WeatherIcon]
    let sys: Sys
    let coord: Coord
    
    private enum CodingKeys: String, CodingKey {
        case name
        case weather = "main"
        case icon = "weather"
        case sys = "sys"
        case coord
    }
    
    enum WeatherKeys: String, CodingKey {
        case temperature = "temp"
        case humidity = "humidity"
        
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        icon = try container.decode([WeatherIcon].self, forKey: .icon)
        sys = try container.decode(Sys.self, forKey: .sys)
        coord = try container.decode(Coord.self, forKey: .coord)
        
        let weatherContainer = try container.nestedContainer(keyedBy: WeatherKeys.self, forKey: .weather)
        let temperature = try weatherContainer.decode(Double.self, forKey: .temperature)
        let humidity = try weatherContainer.decode(Int.self, forKey: .humidity)
        
        weather = Weather(city: name, temperature: temperature, icon: icon.first!.icon, sunrise: sys.sunrise, sunset: sys.sunset, humidity: humidity, latitude: coord.lat, longitude: coord.lat )
    }
}

struct Sys: Decodable {
    let sunrise: Date
    let sunset: Date
    
    enum CodingKeys: CodingKey {
        case sunrise
        case sunset
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let sunriseTimeInterval = try container.decode(Int32.self, forKey: .sunrise)
        let sunsetTimeInterval = try container.decode(Int32.self, forKey: .sunset)
        
        sunrise = Date(timeIntervalSince1970: TimeInterval(sunriseTimeInterval))
        sunset = Date(timeIntervalSince1970: TimeInterval(sunsetTimeInterval))
    }
}

struct Coord: Decodable {
    let lat: Double
    let lon: Double
}

struct WeatherIcon: Decodable {
    let main: String
    let description: String
    let icon: String
}
