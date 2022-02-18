//
//  WeatherData.swift
//  Clima
//
//  Created by Nicolas Dolinkue on 16/02/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
// decorable es por la info que viene de afuera en este caso JSON
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
struct Wind: Codable {
    let speed: Double
}
