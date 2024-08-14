//
//  UserDefaults+Extensiıns.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 13.08.2024.
//

import Foundation

extension UserDefaults {
    
    var unit: TemperatureUnit {
        guard let value = self.value(forKey: "unit") as? String else {
            return .kelvin
        }
        return TemperatureUnit(rawValue: value) ?? .kelvin
    }
    
}
