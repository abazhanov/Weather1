//
//  AddCityViewController.swift
//  Weather1
//
//  Created by Artem Bazhanov on 09.05.2021.
//

import UIKit

class AddCityViewController: UIViewController {
    
    @IBOutlet weak var addCityTF: UITextField!
    @IBOutlet weak var spinnerActivityIndicator: UIActivityIndicatorView!
    
    var delegate: AddCityViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerActivityIndicator.hidesWhenStopped = true
    }
    
    @IBAction func AddButtonPressed() {
        
        showSpinner(show: true)
        
        guard let newCity = addCityTF.text else { return }
        
        NetworkManager.shared.fetchCurrentWeatherData(city: newCity) { (result) in
            switch result {
            case .success(_):
                print("Город найден!")
            case .failure(_):
                print("Город не найден!")
                DispatchQueue.main.async {
                    self.showAlert(with: "Город не найден!", and: "Попробуйте написать название по другому.")
                }
            }
        }
        showSpinner(show: false)
        
        
        delegate.updateCities(newCity: newCity)
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
}

extension AddCityViewController {
    private func showSpinner(show: Bool) {
        switch show {
        case true:
            spinnerActivityIndicator.startAnimating()
            spinnerActivityIndicator.hidesWhenStopped = true
        default:
            spinnerActivityIndicator.stopAnimating()
        }
    }
}

extension AddCityViewController {
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
    
        alert.addAction(okAction)
       
        present(alert, animated: true)
    }
}
