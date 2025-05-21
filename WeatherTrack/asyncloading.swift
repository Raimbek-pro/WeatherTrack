//
//  asyncloading.swift
//  WeatherTrack
//
//  Created by Райымбек Омаров on 21.05.2025.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var forecastDays: [ForecastDay] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let weatherService = WeatherService()

    func fetchWeather() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let result = try await weatherService.fetchWeather(for: "Norilsk")
            self.forecastDays = result.forecast.forecastday
        } catch {
            self.errorMessage = "Failed to load weather: \(error.localizedDescription)"
        }
    }
}
