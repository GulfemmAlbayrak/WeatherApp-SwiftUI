//
//  Weather.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 13.08.2024.
//

import Foundation

struct Weather: Decodable {
    let city: String
    let temperature: Double
    let icon: String
    let sunrise : Date
    let sunset: Date
    let humidity: Int
    let latitude: Double
    let longitude: Double
}

