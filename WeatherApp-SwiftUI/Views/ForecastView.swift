//
//  ForecastView.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 15.08.2024.
//

import SwiftUI

struct ForecastView: View {
    @ObservedObject var viewModel: WeatherDetailViewModel
    @EnvironmentObject var store: Store
    
    var body: some View {
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
    }
}
