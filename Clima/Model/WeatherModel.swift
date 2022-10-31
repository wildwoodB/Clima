//
//  WeatherModel.swift
//  Clima
//
//  Created by Админ on 12.09.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let conditionId: Int
    let cityName: String
    var temperature: Double
    
    // форматирование возращаемой температуры из дабла в стринг с 1 знаком после запятой.
    // или как из дабла сделать строку!!
    var temperatureString: String {
        return String(format: "%.1f", temperature)
     }
    
    
    // свич выборка из деапозона присылыаемого кода погоды с сервера и на основе диапозонов возращает название изображения для вьюхи
    var conditionName: String {
        
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "smoke"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "sun.min"
    
        }
    }
    
    
    
    
}
