//
//  StorageManager.swift
//  Weather1
//
//  Created by Artem Bazhanov on 10.05.2021.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()

    private init() {}
    
    func addCity(city: String) {
        var cities = getCities()
        cities.append(city)
        UserDefaults.standard.set(cities, forKey: "Cities")
    }
    
    func deleteCity(at index: Int) {
        var cities = getCities()
        cities.remove(at: index)
        UserDefaults.standard.set(cities, forKey: "Cities")
    }
    
    func getCities() ->[String] {
        guard let cities = UserDefaults.standard.stringArray(forKey: "Cities") else { return [] }
        return cities
    }
    
    func updateCities(cities: [String]) {
        UserDefaults.standard.set(cities, forKey: "Cities")
    }
}
