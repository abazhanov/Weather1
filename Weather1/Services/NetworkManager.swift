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
        //print("components: ", components)
        let url = components.url!
        //print("url: ", url)
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            guard let data = data else {
                //print("Create data error: ", error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: data)
                completion(.success(currentWeather))
            } catch let error {
                //print("Decode error: ",error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchIconWeatherData(partURL: String, completion: @escaping(Data)->()) {
             
        guard let url = URL(string: "http://openweathermap.org/img/wn/\(partURL)@4x.png") else {return}
        //print("URL = \(url)")
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
        //print("components: ", components)
        let url = components.url!
        print("url: ", url)
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            guard let data = data else {
                //print("Create data error: ", error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let forecast5Days = try JSONDecoder().decode(Forecast5days.self, from: data)
                completion(.success(forecast5Days))
            } catch let error {
                //print("Decode error: ",error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    //MARK: Forecast 16 days
    func fetchForecst16DaysData(city: String, completion: @escaping(Result<Forecast16Days, Error>) -> () ) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast/daily"
        let queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: APIKey),
            URLQueryItem(name: "lang", value: "ru"),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        guard var components = URLComponents(string: urlString) else { return }
        components.queryItems = queryItems
        //print("components 16 days: ", components)
        let url = components.url!
        //print("url 16 days: ", url)
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            guard let data = data else {
                //print("Create data error 16 days: ", error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let forecast16days = try JSONDecoder().decode(Forecast16Days.self, from: data)
                var dt = Double(forecast16days.list[0].dt)
                //print(NSDate(timeIntervalSince1970: dt))
                dt = Double(forecast16days.list[1].dt)
                //print(NSDate(timeIntervalSince1970: dt))
                dt = Double(forecast16days.list[2].dt)
                //print(NSDate(timeIntervalSince1970: dt))
                dt = Double(forecast16days.list[3].dt)
                //print(NSDate(timeIntervalSince1970: dt))
                dt = Double(forecast16days.list[4].dt)
                //print(NSDate(timeIntervalSince1970: dt))
                
                DispatchQueue.main.async {
                    //print("aaaaa")
                    //let newDT = Date(timeIntervalSince1970: dt)
                    
                    //print(self.dayOfWeek(dateTime: Date(timeIntervalSince1970: dt)))
                }
                
                completion(.success(forecast16days))
            } catch let error {
                print("Decode error 16 days: ",error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
    
    private func dayOfWeek(dateTime: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: dateTime).capitalized
        // or use capitalized(with: locale) if you want
    }
    
}
