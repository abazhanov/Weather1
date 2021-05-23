//
//  CityListTableViewController.swift
//  Weather1
//
//  Created by Artem Bazhanov on 08.05.2021.
//

import UIKit

protocol AddCityViewControllerDelegate {
    func updateCities(newCity: String)
}

class CityListTableViewController: UITableViewController {
    
    var cities: [String] = []
    var delegate: CityListTableViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        cities = StorageManager.shared.getCities()
        //print("cities: ", cities)
        navigationItem.leftBarButtonItem = editButtonItem
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addCityVC = segue.destination as? AddCityViewController else { return }
        addCityVC.delegate = self
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("cities.count: ", cities.count)
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CityListTableViewCell
        cell.textLabel?.text = cities[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            
            if cities.count > 1 {
                
                
                
                print("До удаления:", cities)
                
                StorageManager.shared.deleteCity(at: indexPath.row)
                cities = StorageManager.shared.getCities()
                print("После удаления:", cities)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                showAlert(with: "Ошибка удаления!", and: "Нельзя удалить единственный город")
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let currentCity = cities.remove(at: sourceIndexPath.row)
        cities.insert(currentCity, at: destinationIndexPath.row)
        StorageManager.shared.updateCities(cities: cities)
    }
}

extension CityListTableViewController: AddCityViewControllerDelegate {
    func updateCities(newCity: String) {
        StorageManager.shared.addCity(city: newCity)
        cities = StorageManager.shared.getCities()
        tableView.reloadData()
    }
}

extension CityListTableViewController {
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
        StorageManager.shared.updateCities(cities: cities)
        print("ДО: ", cities)
        cities = StorageManager.shared.getCities()
        print("ПОСЛЕ: ", cities)
        
        delegate.updateCities(cities: cities)
        
    }
}

extension CityListTableViewController {
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
    
        alert.addAction(okAction)
       
        present(alert, animated: true)
    }
}
