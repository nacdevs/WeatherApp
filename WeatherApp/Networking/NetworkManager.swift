//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Nestor Camela on 23/12/2025.
//

import Foundation

enum NetworkUseCase: Error, Equatable {
    case networkError
    case notAuth
    case parseError
    case badURL
}

struct AppConstants {
    static let apiBaseURL = "https://api.openweathermap.org/data/2.5/"
    static let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String ?? "" // Should go on FastLane FastFile but POC.
}

struct NetworkManager<T: Codable> {
    static func getData(_ url: String) async throws -> T {
        do {
            guard let fullURL = URL(string: AppConstants.apiBaseURL + url + AppConstants.apiKey) else{
                throw NetworkUseCase.badURL
            }
            let (data, response) = try await URLSession.shared.data(from: fullURL)
            print(fullURL)
            guard let res = response as? HTTPURLResponse else { throw NetworkUseCase.networkError }
            print(res.statusCode)
            guard res.statusCode >= 200 && res.statusCode < 300 else { throw NetworkUseCase.notAuth }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkUseCase.parseError }
            return decodedResponse
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
