//
//  weatherFetcher.swift
//  WeatherTrack
//
//  Created by Райымбек Омаров on 21.05.2025.
//

import Foundation

struct WeatherService {
    private let apiKey = "18b43aba99dd4bf29ec171343252105"
    private let baseURL = "https://api.weatherapi.com/v1/forecast.json"

    func fetchWeather(for city: String, days: Int = 5) async throws -> WeatherResponse {
        guard let url = makeURL(city: city, days: days) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(WeatherResponse.self, from: data)
    }

    private func makeURL(city: String, days: Int) -> URL? {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "days", value: "\(days)")
        ]
        return components?.url
    }
}
