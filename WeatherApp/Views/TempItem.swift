//
//  Untitled.swift
//  WeatherApp
//
//  Created by Nestor Camela on 23/12/2025.
//
import SwiftUI

struct TempItem: View {
    let title: String
    let value: Double

    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)

            Text(String(format: "%.1f°",value))
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
    }
}

