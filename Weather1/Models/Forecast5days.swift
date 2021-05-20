//
//  Forecast5days.swift
//  Weather1
//
//  Created by Artem Bazhanov on 10.05.2021.
//

import Foundation

struct Forecast5days: Decodable {
    let list: [List]
}

struct List: Decodable {
    let dt: Int
    let main: Main
    let wind: Wind
    let weather: [Weather]
}
