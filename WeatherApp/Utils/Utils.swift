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

enum LocalizedStrings {
    static let weatherTitle = NSLocalizedString("weather.title", comment: "")
    static let min = NSLocalizedString("weather.min", comment: "")
    static let max = NSLocalizedString("weather.max", comment: "")
    static let sunrise = NSLocalizedString("weather.sunrise", comment: "")
    static let sunset = NSLocalizedString("weather.sunset", comment: "")
    
    
///MARK:  Errors
    static let noInternetTitle = NSLocalizedString("error.no.internet.title", comment: "")
    static let noInternetDescription = NSLocalizedString("error.no.internet.description", comment: "")
    
///MARK:  Buttons
    static let alertGotIt = NSLocalizedString("alert.gotIt", comment: "")
    
///MARK: Locations
    static let waitLocation = NSLocalizedString("location.wait", comment: "")
    static let locationNoAuth = NSLocalizedString("location.noAuth", comment: "")
}
