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
        performRequest(urlString: urlString) // devolviendo el urlstring lo pasamos a la otra funcions
    }
    
    func performRequest (urlString: String){
        
        // 1. create a url, el if es para el error nil
        if let url = URL(string: urlString) {
            
        
            //2. UrlSession
        
            let session = URLSession(configuration: .default)
            
            //3. give the session a task, lo que hace el task es que busca la info de la pagina que le ponemos y la trae.
            // aplicamos closures para datatask
            
            
            let task = session.dataTask(with: url) { (data , response , error ) in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    parseJSON(weatherData: safeData)
                    
                }
            }
            
            //4. start the task
            task.resume()
       }
    }
    func parseJSON (weatherData: Data){
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodeData.main.temp)
            let id = decodeData.weather[0].id
            print (getConditionName(weatehrID: id))
            
        }catch {
            print(error)
        }
    }
    func getConditionName(weatehrID: Int) -> String {
        
        switch weatehrID {
        case 200...299:
            return "cloud.bolt"
        case 300...399:
            return "cloud.drizzle"
        case 500...599:
            return "cloud.rain"
        case 600...699:
            return "cloud.snow"
        case 700...799:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...899:
            return "cloud.bolt"
        default:
            return "cloud"
        }
        
        
        
        
    }
}
