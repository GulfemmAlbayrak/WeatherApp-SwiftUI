//
//  WeatherInfoView.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 15.08.2024.
//
import SwiftUI

struct WeatherInfoView: View {
    let weather: WeatherViewModel
    @EnvironmentObject var store: Store
    @ObservedObject var viewModel: WeatherDetailViewModel
    
    var body: some View {
        VStack {
            weatherInfoRow(
                systemName: "thermometer",
                text: "Temperature: \(String(format: "%.1f", viewModel.getTemperatureByUnit(tempInKelvin: weather.main.temp, unit: store.selectedUnit))) \(store.selectedUnit.displayText.prefix(1))",
                color: .blue
            )
            
            weatherInfoRow(
                systemName: "humidity",
                text: "Humidity: \(weather.main.humidity)%",
                color: .purple
            )
            
            weatherInfoRow(
                systemName: "wind",
                text: "Wind Speed: \(String(format: "%.1f", weather.wind.speed)) m/s",
                color: .green
            )
            
            weatherInfoRow(
                systemName: "sunrise",
                text: "Sunrise: \(Date(timeIntervalSince1970: TimeInterval(weather.sys.sunrise)).formattedTime())",
                color: .orange
            )
            
            weatherInfoRow(
                systemName: "sunset",
                text: "Sunset: \(Date(timeIntervalSince1970: TimeInterval(weather.sys.sunset)).formattedTime())",
                color: .red
            )
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(red: 0.902, green: 0.902, blue: 0.980))
                .shadow(radius: 5)
        )
        .padding(6)
    }

    private func weatherInfoRow(systemName: String, text: String, color: Color) -> some View {
        HStack {
            Image(systemName: systemName)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(color)
            Text(text)
                .font(.headline)
                .foregroundColor(color)
        }
    }
}
