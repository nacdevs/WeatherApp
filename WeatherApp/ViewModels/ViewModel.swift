//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Nestor Camela on 23/12/2025.
//

import Foundation

class ViewModel: ObservableObject{
    @Published var response: Response?
    
    @MainActor
    func getWeather(coord: Coord) async throws  {
        do{
            let data = try await NetworkManager<Response>.getData("weather?lat=\(coord.lat)&lon=\(coord.lon)&units=metric")
            self.response = data
        }catch{
            print(error)
            throw error
        }
    }
}
