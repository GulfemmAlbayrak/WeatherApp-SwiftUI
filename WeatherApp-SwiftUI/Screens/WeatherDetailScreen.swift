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
                        .foregroundColor(.secondary) 
                }
                .padding(.top)
                
                WeatherInfoView(weather: weather, viewModel: viewModel)
                
                ForecastView(viewModel: viewModel)
                
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
}

#Preview {
    WeatherListScreen().environmentObject(Store())
}

