//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Nestor Camela on 23/12/2025.
//

import SwiftUI
import CoreLocation

@main
struct WeatherAppApp: App {
    @StateObject private var networkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
            ContentView(cities: [City(coord: Coord(lat: -34.6036232292415, lon:  -58.38166983895168)),
                                 City(coord: Coord(lat: -34.905559032777795, lon: -56.18686263337432)),
                                 City(coord: Coord(lat: 51.513527355508955, lon: -0.08893849190209244)),
                
            ])
            .environmentObject(networkMonitor)
        }
    }
}

