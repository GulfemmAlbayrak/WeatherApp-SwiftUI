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
    
    init() {
        selectedUnit = UserDefaults.standard.unit
    }
    
    func addWeather(_ weather: WeatherViewModel) {
        weatherList.append(weather)
    }
}
