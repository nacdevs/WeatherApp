//
//  ContentView.swift
//  WeatherApp
//
//  Created by Nestor Camela on 23/12/2025.
//

import CoreLocation
import SwiftUI

struct ContentView: View {
    @State var cities: [City]
    @StateObject private var locationManager = LocationManager()
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    @Environment(\.openURL) var openURL
    @SceneStorage("selectedTab") private var selectedTab: Int?
    
    var body: some View {
        VStack {
            if locationManager.authorizationStatus == .authorizedWhenInUse
                || locationManager.authorizationStatus == .authorizedAlways
            {
                if locationManager.location != nil {
                    cityTabs
                } else {
                    Text(LocalizedStrings.waitLocation)
                }
            } else {
                cityTabs
                Button(action: openAppSettings) {
                    HStack {
                        Image(systemName: "location")
                        Text(LocalizedStrings.locationNoAuth)
                            .fontWeight(.light)
                            .font(.footnote)
                    }
                }
            }
        }
        .onAppear {
            locationManager.requestLocationAuthorization()
        }
        .onChange(of: locationManager.location) { location in
            addCurrentLocationCity(location)
        }
        .alert(
            LocalizedStrings.noInternetTitle,
            isPresented: Binding<Bool>(
                get: { !networkMonitor.isConnected },
                set: { _ in }
            )
        ) {
            Button(LocalizedStrings.alertGotIt, role: .cancel) {}
        } message: {
            Text(LocalizedStrings.noInternetDescription)
        }
    }
    
    
    private var cityTabs: some View {
        TabView(selection: $selectedTab) {
            ForEach(Array(cities.enumerated()), id: \.offset) {index, city in
                CityView(city: city).tag(index)
                    
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .edgesIgnoringSafeArea(.all)
    }
    

    private func addCurrentLocationCity(_ location: CLLocation?) {
        guard let location else { return }

        let city = City(
            coord: Coord(
                lat: location.coordinate.latitude,
                lon: location.coordinate.longitude
            ),
            isCurrentLocation: true
        )
        if !cities.contains(where: { $0.isCurrentLocation }) {
            cities.insert(city, at: 0)
        }
    }


    private func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            openURL(url)
        }
    }
    
    
}

#Preview {
    //  ContentView()
}
