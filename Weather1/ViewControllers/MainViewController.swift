//
//  ViewController.swift
//  Weather1
//
//  Created by Artem Bazhanov on 07.05.2021.
//

import UIKit

//protocol CityListTableViewControllerDelegate {
//    func updateCities(cities: [String])
//}

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
    
    @IBOutlet weak var forecast5DaysNameLabel1: UILabel!
    @IBOutlet weak var forecast5DaysNameLabel2: UILabel!
    @IBOutlet weak var forecast5DaysNameLabel3: UILabel!
    @IBOutlet weak var forecast5DaysNameLabel4: UILabel!
    @IBOutlet weak var forecast5DaysNameLabel5: UILabel!
    
    @IBOutlet weak var PageControl: UIPageControl!
    
    //var cities: [String] = []
    
    var citiesFromPageView: String!
    var indexOfCurrentCity = 0
    var numberOfCities = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PageControl.numberOfPages = numberOfCities
        PageControl.currentPage = indexOfCurrentCity
        
        
        //print("Main - город: \(citiesFromPageView)")

        showCurrentWeather(for: citiesFromPageView)
        showForecast16Days(for: citiesFromPageView)
        
        
    }
    
//    @IBAction func leftCityButtonPressed() {
//        let currentCity = title
//        var indexOfCity = 0
//        var leftIndexOfCity: Int
//        //print("cities.count", cities.count)
//        for index in 0...cities.count - 1 {
//            if cities[index] == currentCity {
//                indexOfCity = index
//            }
//        }
//        //print("index: ", indexOfCity)
//        if indexOfCity == 0 {
//            leftIndexOfCity = cities.count - 1
//        } else {
//            leftIndexOfCity = indexOfCity - 1
//        }
//
//        showCurrentWeather(for: cities[leftIndexOfCity])
//        showForecast16Days(for: cities[leftIndexOfCity])
//    }
//
//    @IBAction func rightCityButtonPressed() {
//        let currentCity = title
//        var indexOfCity = 0
//        var rightIndexOfCity: Int
//        //print("cities.count", cities.count)
//        for index in 0...cities.count - 1 {
//            if cities[index] == currentCity {
//                indexOfCity = index
//            }
//        }
//        //print("index: ", indexOfCity)
//        if indexOfCity == cities.count - 1 {
//            rightIndexOfCity = 0
//        } else {
//            rightIndexOfCity = indexOfCity + 1
//        }
//
//        showCurrentWeather(for: cities[rightIndexOfCity])
//        showForecast16Days(for: cities[rightIndexOfCity])
//    }
    
    

    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let navBarVC = segue.destination as? UINavigationController else { return }
//        let cityListVC = navBarVC.topViewController as! CityListTableViewController
//        cityListVC.cities = cities
//        //cityListVC.delegate = self
//    }
    
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
                //print(currentWeather.weather[0].icon)
                
                DispatchQueue.main.async {
                    self.title = currentWeather.name
                    self.currentWeatherDescriptionLabel.text = currentWeather.weather[0].description
                    self.currentWeatherTempLabel.text = String(lroundf(currentWeather.main.temp)) + " ºC"
                    
                    self.currentPressureLabel.text = String(currentWeather.main.pressure) + " мм рт. ст."
                    self.currentHumidityLabel.text = String(currentWeather.main.humidity) + " %"
                    self.currentWindSpeedLabel.text = String(currentWeather.wind.speed) + " м/с"
                }
                
                NetworkManager.shared.fetchIconWeatherData(partURL: currentWeather.weather[0].icon) { (data) in
                    //print("Data icon", data)
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
                //print(forecast5Days)
                DispatchQueue.main.async {
                    
                    self.forecast5DaysLabel1.text = String(lroundf(forecast5Days.list[0].main.temp)) + " ºC"
                    NetworkManager.shared.fetchIconWeatherData(partURL: forecast5Days.list[0].weather[0].icon) { (data) in
                        //print("!!!!!!!Data icon", data)
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.forecast5DaysUIImageView1.image = image
                        }
                    }
                    
                    self.forecast5DaysLabel2.text = String(lroundf(forecast5Days.list[1].main.temp)) + " ºC"
                    NetworkManager.shared.fetchIconWeatherData(partURL: forecast5Days.list[1].weather[0].icon) { (data) in
                        //print("!!!!!!!Data icon", data)
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.forecast5DayUIImageView2.image = image
                        }
                    }
                    
                    self.forecast5DaysLabel3.text = String(lroundf(forecast5Days.list[2].main.temp)) + " ºC"
                    NetworkManager.shared.fetchIconWeatherData(partURL: forecast5Days.list[2].weather[0].icon) { (data) in
                        //print("!!!!!!!Data icon", data)
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.forecast5DayUIImageView3.image = image
                        }
                    }
                    
                    self.forecast5DaysLabel4.text = String(lroundf(forecast5Days.list[3].main.temp)) + " ºC"
                    NetworkManager.shared.fetchIconWeatherData(partURL: forecast5Days.list[3].weather[0].icon) { (data) in
                        //print("!!!!!!!Data icon", data)
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.forecast5DayUIImageView4.image = image
                        }
                    }
                    
                    self.forecast5DaysLabel5.text = String(lroundf(forecast5Days.list[4].main.temp)) + " ºC"
                    NetworkManager.shared.fetchIconWeatherData(partURL: forecast5Days.list[4].weather[0].icon) { (data) in
                        //print("!!!!!!!Data icon", data)
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
    
    //MARK: Forecast 16 days
    private func showForecast16Days(for city: String) {
        NetworkManager.shared.fetchForecst16DaysData(city: city) { (result) in
            switch result {
            case .success(let forecast16Days):
                //print("forecast16Days:", forecast16Days)
                DispatchQueue.main.async {
                    
                    self.forecast5DaysLabel1.text = String(lroundf(forecast16Days.list[0].temp.day)) + " ºC"
                    self.forecast5DaysNameLabel1.text = String(self.dayOfWeek(dateTime: Date(timeIntervalSince1970: Double(forecast16Days.list[0].dt))))
                    NetworkManager.shared.fetchIconWeatherData(partURL: forecast16Days.list[0].weather[0].icon) { (data) in
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.forecast5DaysUIImageView1.image = image
                        }
                    }
                    
                    self.forecast5DaysLabel2.text = String(lroundf(forecast16Days.list[1].temp.day)) + " ºC"
                    self.forecast5DaysNameLabel2.text = String(self.dayOfWeek(dateTime: Date(timeIntervalSince1970: Double(forecast16Days.list[1].dt))))
                    NetworkManager.shared.fetchIconWeatherData(partURL: forecast16Days.list[1].weather[0].icon) { (data) in
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.forecast5DayUIImageView2.image = image
                        }
                    }
                    
                    self.forecast5DaysLabel3.text = String(lroundf(forecast16Days.list[2].temp.day)) + " ºC"
                    self.forecast5DaysNameLabel3.text = String(self.dayOfWeek(dateTime: Date(timeIntervalSince1970: Double(forecast16Days.list[2].dt))))
                    NetworkManager.shared.fetchIconWeatherData(partURL: forecast16Days.list[2].weather[0].icon) { (data) in
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.forecast5DayUIImageView3.image = image
                        }
                    }
                    
                    self.forecast5DaysLabel4.text = String(lroundf(forecast16Days.list[3].temp.day)) + " ºC"
                    self.forecast5DaysNameLabel4.text = String(self.dayOfWeek(dateTime: Date(timeIntervalSince1970: Double(forecast16Days.list[3].dt))))
                    NetworkManager.shared.fetchIconWeatherData(partURL: forecast16Days.list[3].weather[0].icon) { (data) in
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.forecast5DayUIImageView4.image = image
                        }
                    }
                    
                    self.forecast5DaysLabel5.text = String(lroundf(forecast16Days.list[4].temp.day)) + " ºC"
                    self.forecast5DaysNameLabel5.text = String(self.dayOfWeek(dateTime: Date(timeIntervalSince1970: Double(forecast16Days.list[4].dt))))
                    NetworkManager.shared.fetchIconWeatherData(partURL: forecast16Days.list[4].weather[0].icon) { (data) in
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.forecast5DayUIImageView5.image = image
                        }
                    }
                    
                }
            case .failure(let error):
                print("forecast16Days error: ", error)
            }
        }
    }
    
    private func dayOfWeek(dateTime: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: dateTime).capitalized
        // or use capitalized(with: locale) if you want
    }
    
//    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
//        let translation = recognizer.translation(in: view)
//        if let view = recognizer.view {
//            print("Значение свайпа", translation.x)
//            print("Значение state", recognizer.state)
//            if recognizer.state == UIGestureRecognizer.State.ended {
//                print("UIGestureRecognizer.State.ended")
//                if translation.x > 0 {
//                    rightCityButtonPressed()
//                } else {
//                    leftCityButtonPressed()
//                }
//            }
//        } else {
//            print("ЧТО-ТО ПОШЛО НЕ ТАК!")
//        }
//    }
    
}

//extension MainViewController: CityListTableViewControllerDelegate {
//    func updateCities(cities: [String]) {
//        self.cities = StorageManager.shared.getCities()
//       print("self.cities: ", self.cities)
//    }
//    
//    
//}
