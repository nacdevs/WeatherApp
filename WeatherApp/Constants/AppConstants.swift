//
//  AppConstants.swift
//  WeatherApp
//
//  Created by Nestor Camela on 24/12/2025.
//
import Foundation

struct AppConstants {
    static let apiBaseURL = "api.openweathermap.org"
    static let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
}
