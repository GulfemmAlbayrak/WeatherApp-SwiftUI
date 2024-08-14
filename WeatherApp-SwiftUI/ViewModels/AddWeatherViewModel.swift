//
//  AddWeatherViewModel.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 13.08.2024.
//

import Foundation

class AddWeatherViewModel: ObservableObject {
    
    var city: String = ""
    
    func save(completion: @escaping (WeatherViewModel) -> Void) {
        
        WebService().getWeatherByCity(city: city) { (result) in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    completion(WeatherViewModel(weather: weather))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

