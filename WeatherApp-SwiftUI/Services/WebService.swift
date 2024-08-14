//  WebService.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 13.08.2024.
//

import Foundation

enum NetworkError: Error {
    case badeURL
    case noData
}

class WebService {
    func getWeatherByCity(city: String, completion: @escaping ((Result<Weather, NetworkError>) -> Void)) {
        guard let weatherURL = Constants.Urls.weatherByCity(city: city) else {
            return completion(.failure(.badeURL))
        }
        
        URLSession.shared.dataTask(with: weatherURL) { (data, _, error) in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            if let weatherResponse = weatherResponse {
                completion(.success(weatherResponse.weather))
            }
        }.resume()
    }
    
    func fetchHourlyWeather(lat: Double, lon: Double, completion: @escaping ((Result<[HourlyWeather], NetworkError>) -> Void)) {
        guard let url = Constants.Urls.hourlyWeather(lat: lat, lon: lon) else {
            return completion(.failure(.badeURL))
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let hourlyWeatherResponse = try? JSONDecoder().decode(HourlyWeatherResponse.self, from: data)
            if let hourlyWeatherResponse {
                completion(.success(hourlyWeatherResponse.list))
            } else {
                completion(.failure(.noData))
            }
        }.resume()
    }
}
