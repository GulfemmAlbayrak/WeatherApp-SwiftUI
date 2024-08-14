//
//  WeatherDetailViewModel.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 14.08.2024.
//

import Foundation

class WeatherDetailViewModel: ObservableObject {
    @Published var hourlyWeather: [HourlyWeather] = []
    
    func fetchHourlyWeather(lat: Double, lon: Double) {
        WebService().fetchHourlyWeather(lat: lat, lon: lon) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let hourlyWeather):
                    self?.hourlyWeather = hourlyWeather
                case .failure(let error):
                    print("Failed to fetch hourly weather data: \(error)")
                }
            }
        }
    }
}
