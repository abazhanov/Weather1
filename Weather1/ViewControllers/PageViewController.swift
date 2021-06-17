//
//  PageViewController.swift
//  Weather1
//
//  Created by Artem Bazhanov on 27.05.2021.
//

import UIKit

protocol CityListTableViewControllerDelegate {
    func updateCities(cities: [String])
}

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
 
    var cities: [String] = []
    var currentCityIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        //print("PageViewController")
        self.dataSource = self
       
        cities = StorageManager.shared.getCities()
        
        print("cities.count = \(cities.count)")
        
        if cities == [] {
            cities.append("Нижний Новгород")
            StorageManager.shared.addCity(city: "Нижний Новгород")
            
        }
        title = cities[0]
        if let vc = returnPageViewController(for: currentCityIndex) {
                setViewControllers([vc], direction: .forward, animated: false, completion: nil)
            print("currentCityIndex Init = \(currentCityIndex)")
        }
        
        
        
//        setViewControllers([returnPageViewController(for: 1)], direction: .forward, animated: false) { (bool) in
//            <#code#>
//        }
        
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navBarVC = segue.destination as? UINavigationController else { return }
        let cityListVC = navBarVC.topViewController as! CityListTableViewController
        cityListVC.cities = cities
        cityListVC.delegate = self
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = ((viewController as? MainViewController)?.index ?? 0)
        print("index Before = \(index)")
        index -= 1
        print("index Before = \(index)")
        return returnPageViewController(for: index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = ((viewController as? MainViewController)?.index ?? 0)
        print("index After = \(index)")
        index += 1
        print("index After = \(index)")
        return returnPageViewController(for: index)
    }

    func returnPageViewController(for index: Int) -> MainViewController? {
        if index < 0 {
            print("Индекс меньше нуля")
            return nil
        }
        
        if index >= cities.count {
            print("Индекс больше количества значений в массиве")
            return nil
        }
        print("Я тут. Значение index = \(index)")
        let navVC = storyboard?.instantiateViewController(withIdentifier: "navVC") as! UINavigationController
        let vc = navVC.topViewController as! MainViewController
        //print("VC = ", vc)
        print("index = \(index)")
        vc.citiesFromPageView = cities[index]
        print("vc.citiesFromPageView = \(cities[index])")
        vc.index = index
        print("vc.index = \(index)")
        title = cities[index]
        return vc
    }
    
    
}


extension PageViewController: CityListTableViewControllerDelegate {
    func updateCities(cities: [String]) {
        self.cities = StorageManager.shared.getCities()
       print("self.cities: ", self.cities)
    }
    
    
}
