//
//  ContentView.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 13.08.2024.
//

import SwiftUI

enum Sheets: Identifiable {
    var id: UUID {
        return UUID()
    }
    
    case addNewCity
    case settings
}

struct WeatherListScreen: View {
    
    @EnvironmentObject var store: Store
    @State private var activeSheet: Sheets?
    
    var body: some View {
        
            List {
                ForEach(store.weatherList, id: \.id) { weather in
                    NavigationLink(destination: WeatherDetailScreen( viewModel: WeatherDetailViewModel() , weather: weather)) {
                        WeatherCell(weather: weather)
                    }
                }
            }
        .listStyle(PlainListStyle())
        
        .sheet(item: $activeSheet, content: { (item) in
            switch item {
            case .addNewCity:
                AddCityScreen().environmentObject(store)
            case .settings:
                SettingsScreen().environmentObject(store)
            }
        })
        .navigationBarItems(leading: Button(action: {
            activeSheet = .settings
        }) {
            Image(systemName: "gearshape")
        }, trailing: Button(action: {
            activeSheet = .addNewCity
        }, label: {
            Image(systemName: "plus")
        }))
        .navigationTitle("Cities")
        .accentColor(.purple)
        .embedInNavigationView()
    }
}

#Preview {
    WeatherListScreen().environmentObject(Store())
}

struct WeatherCell: View {
    @EnvironmentObject var store: Store
    
    let weather: WeatherViewModel
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                Text(weather.city)
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "sunrise")
                    Text("\(weather.sunrise.formatAsString())")
                }
                HStack {
                    Image(systemName: "sunset")
                    Text("\(weather.sunset.formatAsString())")
                }
            }
            Spacer()
            URLImage(url: Constants.Urls.weatherUrlAsStringByIcon(icon: weather.icon))
                .frame(width: 50, height: 50)
            
            Text("\(Int(weather.getTemperatureByUnit(unit: store.selectedUnit))) \(String(store.selectedUnit.displayText.prefix(1)))")
        }
        .padding()
        .background(Color(red: 0.902, green: 0.902, blue: 0.980, opacity: 0.7))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))

    }
}
