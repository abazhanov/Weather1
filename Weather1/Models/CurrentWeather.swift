//
//  CurrentWeather.swift
//  Weather1
//
//  Created by Artem Bazhanov on 08.05.2021.
//

import Foundation

struct CurrentWeather: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
    let pressure: Int
    let humidity: Float
}
