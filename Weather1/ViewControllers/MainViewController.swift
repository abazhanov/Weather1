//
//  ViewController.swift
//  Weather1
//
//  Created by Artem Bazhanov on 07.05.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var currentWeatherIconUIView: UIImageView!
    @IBOutlet weak var currentWeatherDescriptionLabel: UILabel!
    @IBOutlet weak var currentWeatherTempLabel: UILabel!
    
    var cities: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        cities = getCities()
        print(cities)
        //Нужно добавить реализацию экрана при отсутствии сохраненных гороов
        showCurrentWeather(for: cities.first ?? "Москва")
        
    }
    
    @IBAction func leftCityButtonPressed() {
        let currentCity = title
        var indexOfCity = 0
        var leftIndexOfCity: Int
        print("cities.count", cities.count)
        for index in 0...cities.count - 1 {
            if cities[index] == currentCity {
                indexOfCity = index
            }
        }
        print("index: ", indexOfCity)
        if indexOfCity == 0 {
            leftIndexOfCity = cities.count - 1
        } else {
            leftIndexOfCity = indexOfCity - 1
        }
        
        showCurrentWeather(for: cities[leftIndexOfCity])
    }
    
    @IBAction func rightCityButtonPressed() {
        let currentCity = title
        var indexOfCity = 0
        var rightIndexOfCity: Int
        print("cities.count", cities.count)
        for index in 0...cities.count - 1 {
            if cities[index] == currentCity {
                indexOfCity = index
            }
        }
        print("index: ", indexOfCity)
        if indexOfCity == cities.count - 1 {
            rightIndexOfCity = 0
        } else {
            rightIndexOfCity = indexOfCity + 1
        }
        
        showCurrentWeather(for: cities[rightIndexOfCity])
    }
    
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navBarVC = segue.destination as? UINavigationController else { return }
        let cityListVC = navBarVC.topViewController as! CityListTableViewController
        cityListVC.cities = cities
        
    }
    
    private func getCities() -> [String] {
        //let cities = ["Нижний Новгород"]
        let cities = UserDefaults.standard.stringArray(forKey: "Cities")
        return cities ?? ["Нижний Новгород"]
    }
    
    private func showCurrentWeather(for city: String) {
        NetworkManager.shared.fetchCurrentWeatherData(city: city) { (result) in
            switch result {
            case .success(let currentWeather):
                print(currentWeather.weather[0].icon)
                
                DispatchQueue.main.async {
                    self.title = currentWeather.name
                    self.currentWeatherDescriptionLabel.text = currentWeather.weather[0].description
                    self.currentWeatherTempLabel.text = String(currentWeather.main.temp) + " ºC"
                }
                
                NetworkManager.shared.fetchIconWeatherData(partURL: currentWeather.weather[0].icon) { (data) in
                    print("Data icon", data)
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.currentWeatherIconUIView.image = image
                    }
                }
            case .failure(let error):
                print("Ошибка!", error)
            }
        }
    }

}

