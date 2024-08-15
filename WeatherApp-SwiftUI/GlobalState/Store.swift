//
//  Store.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 13.08.2024.
//

import Foundation

class Store: ObservableObject {
    
    @Published var selectedUnit: TemperatureUnit = .kelvin
    @Published var weatherList: [WeatherViewModel] = [WeatherViewModel]()
    
    private let webService = WebService() // Create an instance of WebService
    
    init() {
        selectedUnit = UserDefaults.standard.unit
        loadSavedCities()
    }
    
    func addWeather(_ weather: WeatherViewModel) {
        if let index = weatherList.firstIndex(where: { $0.city == weather.city }) {
            // Eğer şehir listede varsa, kaldır
            weatherList.remove(at: index)
        }
        // Şehir verisini başa ekle
        weatherList.insert(weather, at: 0)
        saveCities()
    }
    
    func removeWeather(_ weather: WeatherViewModel) {
        weatherList.removeAll { $0.city == weather.city }
        saveCities()
    }
    
    private func saveCities() {
        let cities = weatherList.map { $0.city }
        UserDefaults.standard.set(cities, forKey: "savedCities")
    }
    
    func loadSavedCities() {
        if let savedCities = UserDefaults.standard.array(forKey: "savedCities") as? [String] {
            weatherList.removeAll()
            for city in savedCities.reversed() {
                webService.getWeatherByCity(city: city) { [weak self] result in
                    switch result {
                    case .success(let weather):
                        DispatchQueue.main.async {
                            let weatherViewModel = WeatherViewModel(weather: weather)
                            if !self!.weatherList.contains(where: { $0.city == weatherViewModel.city }) {
                                self?.weatherList.insert(weatherViewModel, at: 0)
                            }
                        }
                    case .failure(let error):
                        print("Error loading city \(city): \(error)")
                    }
                }
            }
        }
    }
}
