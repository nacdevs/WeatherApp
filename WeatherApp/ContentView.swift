//
//  ContentView.swift
//  WeatherApp
//
//  Created by Nestor Camela on 23/12/2025.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    // A list of items to display in the tabs (e.g., city weather data)
    let cities: [City]
    @EnvironmentObject private var networkMonitor: NetworkMonitor

    var body: some View {
        TabView {
            // Iterate over your data source to create a view for each tab
            ForEach(cities, id: \.coord.lat) { city in
                CityView(city: city)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .edgesIgnoringSafeArea(.all) // Extend content to the screen edges
        .alert("No Internet Connection", isPresented: Binding<Bool>(
                        get: { !networkMonitor.isConnected },
                        set: { _ in }
                    )) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text("Please check your network settings and try again.")
                    }
    }
}

#Preview {
  //  ContentView()
}
