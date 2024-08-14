//
//  WeatherDetailViewModel.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 14.08.2024.
//

import Foundation
import Combine

class WeatherDetailViewModel: ObservableObject {
    @Published var forecastList: [ForecastWeather] = []
    @Published var isLoading: Bool = false
    @Published var error: String?

    private let weatherService = WebService() // This should be your service for network calls
    private var cancellables = Set<AnyCancellable>()
    
    func fetchForecast(lat: Double, lon: Double) {
        isLoading = true
        weatherService.fetchForecast(lat: lat, lon: lon)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isLoading = false
                case .failure(let error):
                    self?.isLoading = false
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] forecastResponse in
                self?.forecastList = forecastResponse.list
            }
            .store(in: &cancellables)
    }
    
    func getTemperatureByUnit(tempInKelvin: Double, unit: TemperatureUnit) -> Double {
        switch unit {
        case .celsius:
            return tempInKelvin - 273.15
        case .fahrenheit:
            return (tempInKelvin - 273.15) * 9/5 + 32
        case .kelvin:
            return tempInKelvin
        }
    }
}

