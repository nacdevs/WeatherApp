//
//  Utils.swift
//  WeatherApp
//
//  Created by Nestor Camela on 23/12/2025.
//

import Foundation

extension Double {
    func kelvinToCelsius() -> String {
        "\(Int(self - 273.15))°"
    }
}

extension Int {
    func toHourMinute(timezoneOffset: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self + timezoneOffset))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: date)
    }
}

extension String {

    /// SF Symbol recomendado por Apple para el estado actual
    var sfSymbolName: String {
        switch self.lowercased() {

        case "clear":
            return "sun.max"

        case "clouds":
            return "cloud"

        case "rain":
            return "cloud.rain.fill"

        case "drizzle":
            return "cloud.drizzle.fill"

        case "thunderstorm":
            return "cloud.bolt.rain.fill"

        case "snow":
            return "snow"

        case "mist", "fog", "haze", "smoke", "dust", "sand", "ash":
            return "cloud.fog.fill"

        case "squall", "tornado":
            return "tornado"

        default:
            return "cloud"
        }
    }
}
