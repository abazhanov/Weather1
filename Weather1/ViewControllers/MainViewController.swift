//
//  ViewController.swift
//  Weather1
//
//  Created by Artem Bazhanov on 07.05.2021.
//

import UIKit

protocol CityListTableViewControllerDelegate {
    func updateCities(cities: [String])
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var currentWeatherIconUIView: UIImageView!
    @IBOutlet weak var currentWeatherDescriptionLabel: UILabel!
    @IBOutlet weak var currentWeatherTempLabel: UILabel!
    
    @IBOutlet weak var currentPressureUIImageView: UIImageView!
    @IBOutlet weak var currentPressureLabel: UILabel!
    @IBOutlet weak var currentHumidityUIImageView: UIImageView!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentWindSpeedUIImageView: UIImageView!
    @IBOutlet weak var currentWindSpeedLabel: UILabel!
    
    @IBOutlet weak var forecast5DaysUIImageView1: UIImageView!
    @IBOutlet weak var forecast5DaysLabel1: UILabel!
    @IBOutlet weak var forecast5DayUIImageView2: UIImageView!
    @IBOutlet weak var forecast5DaysLabel2: UILabel!
    @IBOutlet weak var forecast5DayUIImageView3: UIImageView!
    @IBOutlet weak var forecast5DaysLabel3: UILabel!
    @IBOutlet weak var forecast5DayUIImageView4: UIImageView!
    @IBOutlet weak var forecast5DaysLabel4: UILabel!
    @IBOutlet weak var forecast5DayUIImageView5: UIImageView!
    @IBOutlet weak var forecast5DaysLabel5: UILabel!
    
    var cities: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        cities = StorageManager.shared.getCities()
        
        print(cities)
        //Нужно добавить реализацию экрана при отсутствии сохраненных гороов
        showCurrentWeather(for: cities.first ?? "Москва")
        print()
        print()
        print()
        print()
        print()
        showForecast5Days(for: cities.first ?? "Москва")
        
        
        //Вот тут тренировка
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .medium
//         
//        let date = Date(timeIntervalSinceReferenceDate: 1620680400)
//        let a = Date(timeIntervalSince1970: 1620680400)
//         
//        dateFormatter.locale = Locale(identifier: "ru_RU")
//        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
//        
//        print(dateFormatter.string(from: date)) // Jan 2, 2001
//        print(dateFormatter.string(from: a)) // Jan 2, 2001
        
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
        showForecast5Days(for: cities[leftIndexOfCity])
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
        showForecast5Days(for: cities[rightIndexOfCity])
    }
    
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navBarVC = segue.destination as? UINavigationController else { return }
        let cityListVC = navBarVC.topViewController as! CityListTableViewController
        cityListVC.cities = cities
        cityListVC.delegate = self
        
    }
    
//    private func getCities() -> [String] {
//        //let cities = ["Нижний Новгород"]
//        let cities = UserDefaults.standard.stringArray(forKey: "Cities")
//        return cities ?? ["Нижний Новгород"]
//    }
    //MARK: Curren weather
    private func showCurrentWeather(for city: String) {
        NetworkManager.shared.fetchCurrentWeatherData(city: city) { (result) in
            switch result {
            case .success(let currentWeather):
                print(currentWeather.weather[0].icon)
                
                DispatchQueue.main.async {
                    self.title = currentWeather.name
                    self.currentWeatherDescriptionLabel.text = currentWeather.weather[0].description
                    self.currentWeatherTempLabel.text = String(currentWeather.main.temp) + " ºC"
                    
                    self.currentPressureLabel.text = String(currentWeather.main.pressure) + " мм рт. ст."
                    self.currentHumidityLabel.text = String(currentWeather.main.humidity) + " %"
                    self.currentWindSpeedLabel.text = String(currentWeather.wind.speed) + " м/с"
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
    
    //MARK: Forecast 5 days
    private func showForecast5Days(for city: String) {
        NetworkManager.shared.fetchForecst5DaysData(city: city) { (result) in
            switch result {
            case .success(let forecast5Days):
                print(forecast5Days)
                DispatchQueue.main.async {
                    
                    self.forecast5DaysLabel1.text = String(forecast5Days.list[0].main.temp)
                    NetworkManager.shared.fetchIconWeatherData(partURL: forecast5Days.list[0].weather[0].icon) { (data) in
                        print("!!!!!!!Data icon", data)
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.forecast5DaysUIImageView1.image = image
                        }
                    }
                    
                    self.forecast5DaysLabel2.text = String(forecast5Days.list[1].main.temp)
                    NetworkManager.shared.fetchIconWeatherData(partURL: forecast5Days.list[1].weather[0].icon) { (data) in
                        print("!!!!!!!Data icon", data)
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.forecast5DayUIImageView2.image = image
                        }
                    }
                    
                    self.forecast5DaysLabel3.text = String(forecast5Days.list[2].main.temp)
                    NetworkManager.shared.fetchIconWeatherData(partURL: forecast5Days.list[2].weather[0].icon) { (data) in
                        print("!!!!!!!Data icon", data)
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.forecast5DayUIImageView3.image = image
                        }
                    }
                    
                    self.forecast5DaysLabel4.text = String(forecast5Days.list[3].main.temp)
                    NetworkManager.shared.fetchIconWeatherData(partURL: forecast5Days.list[3].weather[0].icon) { (data) in
                        print("!!!!!!!Data icon", data)
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.forecast5DayUIImageView4.image = image
                        }
                    }
                    
                    self.forecast5DaysLabel5.text = String(forecast5Days.list[4].main.temp)
                    NetworkManager.shared.fetchIconWeatherData(partURL: forecast5Days.list[4].weather[0].icon) { (data) in
                        print("!!!!!!!Data icon", data)
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.forecast5DayUIImageView5.image = image
                        }
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    private func getIcon(url: String) -> UIImage {
//
//        NetworkManager.shared.fetchIconWeatherData(partURL: url) { (data) in
//            print("Data icon", data)
//            guard let image = UIImage(data: data) else { return }
//            DispatchQueue.main.async {
//                return image
//            }
//        }
//
//        return
//    }

}

extension MainViewController: CityListTableViewControllerDelegate {
    func updateCities(cities: [String]) {
        self.cities = StorageManager.shared.getCities()
       print("self.cities: ", self.cities)
    }
    
    
}
