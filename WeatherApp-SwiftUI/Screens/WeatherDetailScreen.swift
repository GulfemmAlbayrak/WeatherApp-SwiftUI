//
//  WeatherDetailScreen.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 14.08.2024.
//

import SwiftUI

struct WeatherDetailScreen: View {
    
    @StateObject private var viewModel = WeatherDetailViewModel()
    let weather: WeatherViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // First Card
                VStack(spacing: 10) {
                    Text(weather.city)
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                    
                    URLImage(url: Constants.Urls.weatherUrlAsStringByIcon(icon: weather.icon))
                        .frame(width: 200, height: 200)
                        .padding(.top)
                    
                    Text("\(Int(weather.getTemperatureByUnit(unit: .celsius)))°C")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color.black)
                }
                .padding()
//                .padding(.vertical, 12)
//                .background(Color(red: 0.902, green: 0.902, blue: 0.980, opacity: 0.7)) // Light lila background
//                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 15, style: .continuous)
//                        .stroke(Color.black.opacity(0.2), lineWidth: 1) // Border color and width
//                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Shadow effect
//                )
//                .frame(maxWidth: .infinity)
                
                // Second Card
                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: "sunrise.fill")
                            .foregroundColor(Color.orange)
                        Text("Sunrise: \(weather.sunrise.formatAsString())")
                            .font(.subheadline)
                    }
                    HStack {
                        Image(systemName: "sunset.fill")
                            .foregroundColor(Color.red)
                        Text("Sunset: \(weather.sunset.formatAsString())")
                            .font(.subheadline)
                    }
                    HStack {
                        Image(systemName: "humidity.fill")
                            .foregroundColor(Color.blue)
                        Text("Humidity: \(weather.humidity)%")
                            .font(.subheadline)
                    }
                }
                .padding()
                .background(Color(red: 0.902, green: 0.902, blue: 0.980, opacity: 0.7))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .stroke(Color.black.opacity(0.2), lineWidth: 1) // Border color and width
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Shadow effect
                )
                
                // Hourly Forecast
                Text("Hourly Forecast")
                    .font(.headline)
                    .padding(.top)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(viewModel.hourlyWeather) { hourly in
                            VStack {
                                Text(hourly.dt, style: .time)
                                URLImage(url: Constants.Urls.weatherUrlAsStringByIcon(icon: hourly.icon))
                                    .frame(width: 50, height: 50)
                                Text("\(Int(hourly.temperature))°C")
                            }
                            .padding()
                            .background(Color(red: 0.902, green: 0.902, blue: 0.980, opacity: 0.7))
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .stroke(Color.black.opacity(0.2), lineWidth: 1) // Border color and width
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Shadow effect
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }

            .padding()
            .navigationTitle("Weather Details")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchHourlyWeather(lat: weather.weather.latitude, lon: weather.weather.longitude)
            }
        }
    }
}

