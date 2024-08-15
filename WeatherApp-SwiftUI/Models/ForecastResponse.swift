//
//  ForecastResponse.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 13.08.2024.
//

import Foundation

import Foundation

// MARK: - ForecastResponse
struct ForecastResponse: Codable {
    let list: [ForecastWeather]
    let city: City
}

// MARK: - ForecastWeather
struct ForecastWeather: Codable {
    let dt: Int
    let main: Main
    let weather: [WeatherElement]
    let clouds: Clouds
    let wind: Wind 
    let visibility: Int
    let pop: Double
    let rain: Rain?
    let sys: ForecastSys
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population: Int?
    let timezone, sunrise, sunset: Int
}

// MARK: - Rain
struct Rain: Codable {
    let threeHour: Double?

    enum CodingKeys: String, CodingKey {
        case threeHour = "3h"
    }
}

// MARK: - ForecastSys
struct ForecastSys: Codable {
    let pod: String
}
