//
//  ContentView.swift
//  WeatherTrack
//
//  Created by Райымбек Омаров on 21.05.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Custom Title
                VStack {
                    Text("5-Day Forecast")
                        .font(.title)
                        .bold()
                    Text("in Norilsk")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }

                List(viewModel.forecastDays) { day in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(day.date)
                            .font(.headline)

                        HStack {
                            AsyncImage(url: URL(string: "https:\(day.day.condition.icon)")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 40, height: 40)

                            VStack(alignment: .leading) {
                                Text(day.day.condition.text)
                                Text("🌡 Avg: \(day.day.avgtempC, specifier: "%.1f")°C")
                                Text("💨 Wind: \(day.day.maxwindKph, specifier: "%.0f") km/h")
                                Text("💧 Humidity: \(day.day.avghumidity, specifier: "%.0f")%")
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .padding()
            .task {
                await viewModel.fetchWeather()
            }
        }
    }
}
#Preview {
    ContentView()
}
