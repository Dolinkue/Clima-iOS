//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextFiedl: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextFiedl.delegate = self
    }

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

