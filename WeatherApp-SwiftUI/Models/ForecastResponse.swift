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
    let list: [ForecastWeather] // List of weather forecasts
    let city: City // Information about the city
}

// MARK: - ForecastWeather
struct ForecastWeather: Codable {
    let dt: Int // Forecast time (timestamp)
    let main: Main // Main weather details
    let weather: [WeatherElement] // Weather condition details
    let clouds: Clouds // Cloudiness
    let wind: Wind // Wind details
    let visibility: Int // Visibility
    let pop: Double // Probability of precipitation
    let rain: Rain? // Rain information (optional)
    let sys: ForecastSys // Sys details (e.g., pod)
    let dtTxt: String // Forecast time as text

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
    let pod: String // Part of the day (e.g., "n" for night, "d" for day)
}
