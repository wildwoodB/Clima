//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
// импорт фреймворка дающего доступ к GPS телефона
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func getTheGPSData(_ sender: UIButton) {
        locationManager.requestLocation()
        print(lat,lon)
        
    }
    
    
    var weatherManager = WeatherManager()
    //создание перменной с классом локации
    let locationManager = CLLocationManager()
    
    var lat:Double = 0.0
    var lon:Double = 0.0
    
    /*func returnLat() {
        lat = locationManager.location?.coordinate.latitude ?? 0.0
        lon = locationManager.location?.coordinate.longitude ?? 0.0
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        // запрос к пользователю на разрешение шеринга локации
        locationManager.requestWhenInUseAuthorization()
        // одноразовая доставка локации
        locationManager.requestLocation()
        //
       
        
        // идентифицировали делегейты
        weatherManager.delegate = self
        searchTextField.delegate = self
        
    }
}

// MARK: - UITExtFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    // функция форматирования плейсхолдера если он пустой подставляет строчку
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type sometging..."
            return false
        }
    }
    
    // функия отправляющая текст из запроса в функцию подставляющую этот текст в ссылку для дальнейшего поиска города.
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    //функция возращающая данные о погоде с мэнэджера и везер модели
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        // обдейтер комплишен хендлера (обуславливает задержку получения данных с сервера, и не дает заморозится интефейсу пока данные идут к нам)
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            
        }
        
    }
    // функция отлова ошибки
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate
// расширение с функцией вызова текущего местополождения с данных координат от жпс телефона
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations location: [CLLocation]) {
        if let location = location.last {
            locationManager.stopUpdatingLocation()
            var lat = location.coordinate.latitude
            var lon = location.coordinate.longitude
            weatherManager.fetchWeatherGetGPS(latitude: lat, longitude: lon)
           
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    
    
}
