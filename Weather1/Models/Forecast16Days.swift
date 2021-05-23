//
//  Forecast16Days.swift
//  Weather1
//
//  Created by Artem Bazhanov on 22.05.2021.
//

import Foundation

struct Forecast16Days: Decodable {
    let list: [List16]
}

struct List16: Decodable {
    let dt: Int
    let temp: Temp
    //let wind: Wind
    let weather: [Weather]
}

struct Temp: Decodable {
    let day: Float
}
