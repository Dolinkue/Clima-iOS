//
//  WeatherManager.swift
//  Clima
//
//  Created by Nicolas Dolinkue on 15/02/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager{
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=4227ede7bf3a3abaa9ff3cc467b3ea15&units=metric"
    
    
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(urlString: urlString) // devolviendo el urlstring lo pasamos a la otra funcion
    }
    
    func performRequest (urlString: String){
        // 1. create a url, el if es para el error nil
        if let url = URL(string: urlString) {
            
        
        
        
            //2. UrlSession
        
            let session = URLSession(configuration: .default)
            
            //3. give the session a task, lo que hace el task es que busca la info de la pagina que le ponemos y la trae.
        
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            //4. start the task
            task.resume()
       }
    }
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil{
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
    
}
