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

protocol MainViewControllerDelegate {
    func updateTitle(city: String)
}

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
 
    var cities: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        //print("PageViewController")
        dataSource = self
       
        cities = StorageManager.shared.getCities()
        
        print("cities.count = \(cities.count)")
        
        if cities == [] {
            cities.append("Нижний Новгород")
            StorageManager.shared.addCity(city: "Нижний Новгород")
            
        }
        title = cities[0]
         
        
        if let mainViewController = returnPageViewController(for: 0) {
            setViewControllers([mainViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navBarVC = segue.destination as? UINavigationController else { return }
        let cityListVC = navBarVC.topViewController as! CityListTableViewController
        cityListVC.cities = cities
        cityListVC.delegate = self
    }
    
    
    //Before
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = ((viewController as! MainViewController).PageControl.currentPage)
        title = cities[index]
        index -= 1
        return returnPageViewController(for: index)
        return nil
    }
    
    //After
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = ((viewController as! MainViewController).PageControl.currentPage)
        title = cities[index]
        index += 1
        return returnPageViewController(for: index)
    }
    
    //return View
    func returnPageViewController(for index: Int) -> MainViewController? {
        print("")
        print("returnPageViewController")
        if index < 0 {
            print("Индекс меньше нуля")
            //let vc = storyboard?.instantiateViewController(withIdentifier: "mainVC") as! MainViewController
            //vc.indexOfCurrentCity = index
            return nil
        }
        
        if index >= cities.count {
            print("Индекс больше количества значений в массиве")
            return nil
        }
        print("Я тут. Значение index = \(index)")
        //let navVC = storyboard?.instantiateViewController(withIdentifier: "navVC") as! UINavigationController
        //let vc = navVC.topViewController as! MainViewController
        //print("VC = ", vc)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "mainVC") as! MainViewController
        
        print("index = \(index)")
        
        vc.citiesFromPageView = cities[index]
        print("vc.citiesFromPageView = \(cities[index])")
        
        vc.indexOfCurrentCity = index
        print("vc.index = \(index)")
        
        vc.numberOfCities = cities.count
        
        //title = cities[index]
        return vc
    }
    
    
}


extension PageViewController: CityListTableViewControllerDelegate {    
    func updateCities(cities: [String]) {
        self.cities = StorageManager.shared.getCities()
        
        
        if let vc = returnPageViewController(for: 0) {
                setViewControllers([vc], direction: .forward, animated: false, completion: nil)
            print("currentCityIndex Init = 0")
        }
        
       print("self.cities: ", self.cities)
    }
}

extension PageViewController: MainViewControllerDelegate {
    func updateTitle(city: String) {
        title = city
    }
}
