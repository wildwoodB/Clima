//
//  WeatherData.swift
//  Clima
//
//  Created by Админ on 12.09.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


// разные структуры на осное данных из опенвезара в JSON
struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}


