//
//  ContentView.swift
//  WeatherApp
//
//  Created by Nestor Camela on 23/12/2025.
//

import SwiftUI

struct CityView: View {

    @StateObject var viewModel = ViewModel()
    @State private var showAlert = false
    @State private var error = "Default"
    let city: City

    var body: some View {
        ScrollView{
            VStack(spacing: 24) {

                // City & coordinates
                VStack(spacing: 4) {
                    Text(viewModel.response?.name ?? "")
                        .font(.title)
                        .fontWeight(.semibold)

                    Text("Lat \(city.coord.lat), Lon \(city.coord.lon)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                WeatherIconView(weather: viewModel.response?.weather.first)

                // Current temperature (main focus)
                Text(String(format: "%.1f°",viewModel.response?.main.temp ?? 0))
                    .font(.system(size: 72, weight: .bold))
                    .padding(.vertical)

                // Min / Max
                HStack(spacing: 32) {
                    TempItem(title: "Min", value: viewModel.response?.main.tempMin ?? 0)
                    TempItem(title: "Max", value: viewModel.response?.main.tempMax ?? 0)
                }

                Divider()
                    .padding(.horizontal)

                // Sunrise / Sunset
                HStack(spacing: 40) {
                    SunItem(
                        title: "Sunrise",
                        time: viewModel.response?.sys.sunrise.toHourMinute(
                            timezoneOffset: viewModel.response?.timezone ?? 0
                        ) ?? "",
                        systemImage: "sunrise.fill"
                    )

                    SunItem(
                        title: "Sunset",
                        time: viewModel.response?.sys.sunset.toHourMinute(
                            timezoneOffset: viewModel.response?.timezone ?? 0
                        ) ?? "",
                        systemImage: "sunset.fill"
                    )
                }

                Spacer()
            }
        }
       
        .padding()
        .alert(isPresented: self.$showAlert) {
            Alert(title: Text(self.error),dismissButton: .default(Text("Got it!")))
        }
        .task {
            await callVM()
        }
        .refreshable {
            await callVM()
        }
    }
    
    func callVM() async{
        do{
            try await viewModel.getWeather(coord: city.coord)
        }catch{
            self.error = error.localizedDescription
            self.showAlert = true
        }
    }
}

/*
#Preview {
    ContentView(
        cityName: "Chicago",
        response: mockOneCallResponse
    )
}*/
