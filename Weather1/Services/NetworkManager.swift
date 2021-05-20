//
//  NetworkManager.swift
//  Weather1
//
//  Created by Artem Bazhanov on 08.05.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    //MARK: Current weather
    func fetchCurrentWeatherData(city: String, completion: @escaping(Result<CurrentWeather, Error>) -> () ) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather"
        let queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: APIKey),
            URLQueryItem(name: "lang", value: "ru"),
            URLQueryItem(name: "units", value: "metric")
        ]

        guard var components = URLComponents(string: urlString) else { return }
        components.queryItems = queryItems
        print("components: ", components)
        let url = components.url!
        print("url: ", url)
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            guard let data = data else {
                print("Create data error: ", error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: data)
                completion(.success(currentWeather))
            } catch let error {
                print("Decode error: ",error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchIconWeatherData(partURL: String, completion: @escaping(Data)->()) {
             
        guard let url = URL(string: "http://openweathermap.org/img/wn/\(partURL)@4x.png") else {return}
        print("URL = \(url)")
        let session = URLSession.shared
    
        session.dataTask(with: url) { (data, response, error) in

            guard let data = data else { return }
            completion(data)
    
        }.resume()
    }
    
    //MARK: Forecast 5 days
    func fetchForecst5DaysData(city: String, completion: @escaping(Result<Forecast5days, Error>) -> () ) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast"
        let queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: APIKey),
            URLQueryItem(name: "lang", value: "ru"),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        guard var components = URLComponents(string: urlString) else { return }
        components.queryItems = queryItems
        print("components: ", components)
        let url = components.url!
        print("url: ", url)
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            guard let data = data else {
                print("Create data error: ", error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let forecast5Days = try JSONDecoder().decode(Forecast5days.self, from: data)
                completion(.success(forecast5Days))
            } catch let error {
                print("Decode error: ",error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
        
    }
    
}
