//
//  AddCityScreen.swift
//  WeatherApp-SwiftUI
//
//  Created by Gulfem ALBAYRAK on 13.08.2024.
//

import SwiftUI

struct AddCityScreen: View {
    @EnvironmentObject var store: Store
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var addWeatherVM = AddWeatherViewModel()
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                TextField("Enter City", text: $addWeatherVM.city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Save") {
                    addWeatherVM.save { weather in
                        store.addWeather(weather)
                        presentationMode.wrappedValue.dismiss()
                    }
                }.padding(10)
                .frame(maxWidth: UIScreen.main.bounds.width/4)
                .foregroundColor(Color.white)
                .background(Color.purple)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }.padding()
            .frame(maxWidth: .infinity, maxHeight: 200)
            .background(Color(red: 0.902, green: 0.902, blue: 0.980))
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                Spacer()
            }.padding()
            
                .navigationTitle("Add City")
                .embedInNavigationView()
        }
    }


#Preview {
    AddCityScreen().environmentObject(Store())
}
