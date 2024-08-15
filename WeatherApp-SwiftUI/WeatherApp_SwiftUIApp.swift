//
//  WeatherApp_SwiftUIApp.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 13.08.2024.
//

import SwiftUI

@main
struct WeatherApp_SwiftUIApp: App {
    @State var weather: WeatherViewModel?
    
    var body: some Scene {
        WindowGroup {
            WeatherListScreen().environmentObject(Store())
        }
    }
}
