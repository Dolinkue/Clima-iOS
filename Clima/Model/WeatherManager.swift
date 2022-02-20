//
//  WeatherManager.swift
//  Clima
//
//  Created by Nicolas Dolinkue on 15/02/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager{
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=4227ede7bf3a3abaa9ff3cc467b3ea15&units=metric"
    
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather (cityName: String, latitud: Double, long: Double) {
        let urlString = "\(weatherUrl)&q=\(cityName)&lat=\(latitud)&lon=\(long)"
        performRequest(urlString: urlString) // devolviendo el urlstring lo pasamos a la otra funcions
        print(urlString)
        
    
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
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                }
            }
            
            //4. start the task
            task.resume()
       }
    }
    func parseJSON (_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            print(name)
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
        
        
        
        
    
}
