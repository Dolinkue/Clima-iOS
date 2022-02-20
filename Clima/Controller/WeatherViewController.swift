//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextFiedl: UITextField!
    
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager() // para activar el gps en la localizacion
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // pedir permiso para usar el gps
        locationManager.requestLocation()
        
        
        weatherManager.delegate = self
        searchTextFiedl.delegate = self
    }
    
    @IBAction func currentLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}


    extension WeatherViewController : CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                locationManager.stopUpdatingLocation()
                let lat = location.coordinate.latitude
                let lon = location.coordinate.longitude
                weatherManager.fetchWeather(latitud: lat, long: lon)
                print(lat)
                print(lon)
                
            }
        }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Failed to get users location.")
        }
    
    

//MARK: - UItextFielDelegate
    

}

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        searchTextFiedl.endEditing(true)// aca sacamos el teclado
        print(searchTextFiedl.text!)
        
        
        
    }
    // aca se le dice a la aplicacion que el usuario apreto el boton de buscar o regresar
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print(searchTextFiedl.text!)
        searchTextFiedl.endEditing(true)
        return true
    }
    
    // aca hace lo mismo que mas abajo pero da la opcion de q si preciona te diga que escribas algo antes de cerrar el teclado
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else {
            textField.placeholder = "escribi algo"
            return false
        }
    }
    
    
    
    // aca eliminamos lo que escribimos
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextFiedl.text { // para salavar el optional nil
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextFiedl.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
