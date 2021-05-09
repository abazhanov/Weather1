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
        
        NetworkManager.shared.fetchCurrentWeatherData(city: cities.first ?? "Moscow") { (currentWeather) in
            print("QQQ")
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
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navBarVC = segue.destination as? UINavigationController else { return }
        let cityListVC = navBarVC.topViewController as! CityListTableViewController
        cityListVC.cities = cities
        
    }
    
    private func getCities() -> [String] {
        let cities = ["Нижний Новгород"]
        return cities
    }
    

}

