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
            let queryParams = [URLQueryItem(name: "lat", value: "\(coord.lat)"),
                               URLQueryItem(name: "lon", value: "\(coord.lon)"),
                               URLQueryItem(name: "units", value: "metric")]
            let data = try await NetworkManager<Response>.getData(path: "/weather", queryParams: queryParams)
            self.response = data
        }catch{
            print(error)
            throw error
        }
    }
}
