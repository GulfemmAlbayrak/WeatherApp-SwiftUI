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
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.primary)
                        
                    Text("Date: \(Date(timeIntervalSince1970: TimeInterval(weather.dt)).formattedDate())")
                        .font(.subheadline)
                        .foregroundColor(.secondary)  // Use secondary color
                }
                .padding(.top)
                ZStack {
                    Color.white.edgesIgnoringSafeArea(.all)
                        // Weather information
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
//                        .padding(20)
//                        .background(
//                        RoundedRectangle(cornerRadius: 15)
//                            .fill(Color(red: 0.902, green: 0.902, blue: 0.980))
//                            .shadow(radius: 5)
//                        )
//                        .padding(6)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .background(Color.clear)
                    .padding(20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(red: 0.902, green: 0.902, blue: 0.980))
                        .shadow(radius: 5)
                    )
                    .padding(6)
                }
                // Forecast data
                VStack(alignment: .leading, spacing: 20) {
                    Text("Forecast")
                        .font(.headline)
                        .padding(.bottom, 2)
                        .foregroundColor(.primary)
                    
                    ForEach(viewModel.groupForecastsByDay().keys.sorted(), id: \.self) { date in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(date)
                                .font(.headline)
                                .padding(.bottom, 2)
                                .foregroundColor(.primary)
                            
                            ForEach(viewModel.groupForecastsByDay()[date] ?? [], id: \.dt) { forecast in
                                HStack {
                                    Text(Date(timeIntervalSince1970: TimeInterval(forecast.dt)).formattedTime())
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Text("\(String(format: "%.1f", viewModel.getTemperatureByUnit(tempInKelvin: forecast.main.temp, unit: store.selectedUnit))) \(store.selectedUnit.displayText.prefix(1))")
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Image(systemName: Constants.Icons.weatherIcon(for: forecast.weather.first?.icon ?? "01d"))
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(weatherIconColor(for: forecast.weather.first?.icon ?? "01d"))
                                }
                                .padding(.vertical, 5)
                                .background(Color(UIColor.systemGray6))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                        .padding(.bottom, 20)
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
}
#Preview {
    WeatherListScreen().environmentObject(Store())
}

