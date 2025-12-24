//
//  WeatherIcon.swift
//  WeatherApp
//
//  Created by Nestor Camela on 23/12/2025.
//

import SwiftUI

struct WeatherIconView: View {

    let weather: Weather?
    @State private var isVisible = false

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
                            .opacity(isVisible ? 1 : 0)
                            .offset(y: isVisible ? 0 : 12)
                            .onAppear {
                                withAnimation(.easeOut(duration: 0.5)) {
                                            isVisible = true
                                }
                            }
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
        .frame(width: 120, height: 120)
    }

    private var fallbackIcon: some View {
        Image(systemName: "cloud")
            .font(.system(size: 48))
            .foregroundColor(.secondary)
    }
}
