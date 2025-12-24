//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Nestor Camela on 23/12/2025.
//

import Foundation

struct NetworkManager<T: Codable> {
    static func getData(path: String, queryParams: [URLQueryItem]) async throws -> T {
        do {
            guard let fullURL = createAPIURL(path: path, queryParams: queryParams) else{
                throw NetworkUseCase.badURL
            }
            let (data, response) = try await URLSession.shared.data(from: fullURL)
            guard let res = response as? HTTPURLResponse else { throw NetworkUseCase.networkError }
            print(res.statusCode)
            guard res.statusCode >= 200 && res.statusCode < 300 else { throw NetworkUseCase.notAuthorized }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkUseCase.parseError }
            return decodedResponse
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    private static func createAPIURL(path: String, queryParams: [URLQueryItem]?) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = AppConstants.apiBaseURL
        components.path = "/data/2.5\(path)"
        components.queryItems = queryParams
        components.queryItems?.append(URLQueryItem(name: "appid", value: AppConstants.apiKey))
        
        return components.url
    }

}

//Network Errors
enum NetworkUseCase: Error, Equatable {
    case networkError
    case notAuthorized
    case parseError
    case badURL
}


