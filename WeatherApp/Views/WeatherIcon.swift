//
//  WeatherIcon.swift
//  WeatherApp
//
//  Created by Nestor Camela on 23/12/2025.
//

import SwiftUI

struct WeatherIconView: View {

    let weather: Weather?

    private var iconURL: URL? {
        guard let icon = weather?.icon else { return nil }
        return URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
    }

    var body: some View {
        Group {
            if let url = iconURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure:
                        fallbackIcon
                    @unknown default:
                        fallbackIcon
                    }
                }
            } else {
                fallbackIcon
            }
        }
        .frame(width: 100, height: 100)
    }

    private var fallbackIcon: some View {
        Image(systemName: "cloud")
            .font(.system(size: 48))
            .foregroundColor(.secondary)
    }
}
