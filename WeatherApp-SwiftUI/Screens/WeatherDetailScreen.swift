import SwiftUI

struct WeatherDetailScreen: View {
    
    @EnvironmentObject var store: Store
    @ObservedObject var viewModel: WeatherDetailViewModel

    let weather: WeatherViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header with city name and date
                VStack(alignment: .leading, spacing: 10) {
                    Text(weather.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)  // Use primary color
                        
                    Text("Date: \(Date(timeIntervalSince1970: TimeInterval(weather.dt)).formattedDate())")
                        .font(.subheadline)
                        .foregroundColor(.secondary)  // Use secondary color
                }
                .padding(.top)
                
                // Weather information
                VStack(alignment: .leading, spacing: 15) {
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
                
                // Forecast data
                VStack(alignment: .leading, spacing: 20) {
                    Text("Forecast")
                        .font(.headline)
                        .padding(.bottom, 10)
                        .foregroundColor(.primary)  // Use primary color
                    
                    ForEach(viewModel.forecastList, id: \.dt) { forecast in
                        HStack {
                            Text(Date(timeIntervalSince1970: TimeInterval(forecast.dt)).formattedDate())
                                .font(.subheadline)
                                .foregroundColor(.secondary)  // Use secondary color
                            Spacer()
                            Text("\(String(format: "%.1f", viewModel.getTemperatureByUnit(tempInKelvin: forecast.main.temp, unit: store.selectedUnit))) \(store.selectedUnit.displayText.prefix(1))")
                                .font(.subheadline)
                                .foregroundColor(.primary)  // Use primary color
                            Spacer()
                            Image(systemName: Constants.Icons.weatherIcon(for: forecast.weather.first?.icon ?? "01d"))
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(weatherIconColor(for: forecast.weather.first?.icon ?? "01d"))  // Color based on weather icon
                        }
                        .padding(.vertical, 5)
                        .background(Color(UIColor.systemGray6))  // Light gray background for rows
                        .clipShape(RoundedRectangle(cornerRadius: 8))  // Rounded corners for rows
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(weather.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchForecast(lat: weather.coord.lat, lon: weather.coord.lon)
        }
    }
    
    // Helper View for Weather Info Rows
    private func weatherInfoRow(systemName: String, text: String, color: Color) -> some View {
        HStack {
            Image(systemName: systemName)
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(color)  // Set icon color
            Text(text)
                .font(.headline)
                .foregroundColor(color)  // Set text color
        }
    }
    
    // Determine icon color based on weather condition
    private func weatherIconColor(for iconCode: String) -> Color {
        switch iconCode {
        case "01d", "01n": return .yellow
        case "02d", "02n": return .blue
        case "03d", "03n": return .gray
        case "04d", "04n": return .gray
        case "09d", "09n": return .teal
        case "10d", "10n": return .blue
        case "11d", "11n": return .purple
        case "13d", "13n": return .white
        case "50d", "50n": return .gray
        default: return .primary
        }
    }
}

// Helper Extensions
extension Date {
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    
    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
