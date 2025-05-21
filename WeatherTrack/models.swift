//
//  models.swift
//  WeatherTrack
//
//  Created by Райымбек Омаров on 21.05.2025.
//

import Foundation

struct WeatherResponse: Decodable {
    let forecast: Forecast
}

struct Forecast: Decodable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Decodable, Identifiable {
    let date: String
    let day: Day
    
    var id: String { date }
}

struct Day: Decodable {
    let avgtempC: Double
    let maxwindKph: Double
    let avghumidity: Double
    let condition: Condition
}

struct Condition: Decodable {
    let text: String
    let icon: String
}
