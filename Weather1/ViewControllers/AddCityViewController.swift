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
        
        //var newCityIsExist = 0
        showSpinner(show: true)
        
        guard let newCity = addCityTF.text else { return }
        
        NetworkManager.shared.fetchCurrentWeatherData(city: newCity) { (result) in
            switch result {
            case .success(_):
                print("Город найден!")
                //self.showSpinner(show: false)
                //self.delegate.updateCities(newCity: newCity)
                //_ = self.navigationController?.popViewController(animated: true)
                DispatchQueue.main.async {
                    //newCityIsExist = 1
                    self.delegate.updateCities(newCity: newCity)
                    self.showSpinner(show: false)
                    _ = self.navigationController?.popViewController(animated: true)
                }
                
            case .failure(_):
                print("Город не найден!")
                DispatchQueue.main.async {
                    self.showAlert(with: "Город не найден!", and: "Попробуйте написать название по другому.")
                    self.showSpinner(show: false)
                }
            }
        }
        //showSpinner(show: false)
        
        
        //delegate.updateCities(newCity: newCity)

        
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

//extension AddCityViewController {
//    // Вызывается перед скрытием вью
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        print("viewWillDisappear")
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        print("viewDidDisappear")
//    }
//}
