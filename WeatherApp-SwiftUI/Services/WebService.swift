//  WebService.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 13.08.2024.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError

}

class WebService {
    func getWeatherByCity(city: String, completion: @escaping ((Result<Weather, NetworkError>) -> Void)) {
        guard let weatherURL = Constants.Urls.weatherByCity(city: city) else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: weatherURL) { (data, _, error) in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(.success(weather))
            } catch let decodingError as DecodingError {
                print("Decoding error: \(decodingError)")
                completion(.failure(.decodingError))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchForecast(lat: Double, lon: Double) -> AnyPublisher<ForecastResponse, NetworkError> {
        guard let url = Constants.Urls.forecastByCoordinates(lat: lat, lon: lon) else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ForecastResponse.self, decoder: JSONDecoder())
            .mapError { _ in NetworkError.decodingError }
            .eraseToAnyPublisher()
    }
}
