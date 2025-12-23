//
//  Untitled.swift
//  WeatherApp
//
//  Created by Nestor Camela on 23/12/2025.
//
import SwiftUI

struct SunItem: View {
    let title: String
    let time: String
    let systemImage: String

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: systemImage)
                .foregroundColor(.orange)

            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)

            Text(time)
                .font(.headline)
        }
    }
}

