//
//  HomeViewModel.swift
//  WeatherMVVM
//
//  Created by webwerks on 27/06/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class CurrentWeatherViewModel: NSObject {
    private var currentWeather: CurrentWeather
    
    public init(currentWeather: CurrentWeather) {
        self.currentWeather = currentWeather
    }
    
    public var currentTemp: String {
        let temp = ((currentWeather.main?.temp ?? 273.15) - 273.15) //Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
        return String(format: "%.2f", temp)
    }
    
    public var cityName: String {
        return currentWeather.name ?? "Unknown"
    }
    
    public var maxMinTemp: String {
        let minTemp: Double = (currentWeather.main?.tempMin ?? 273.15) - 273.15
        let maxTemp: Double = (currentWeather.main?.tempMax ?? 273.15) - 273.15
        
        let temp = String(format: "%.2f", minTemp) + "/" + String(format: "%.2f", maxTemp)
        return temp
    }
        
}

extension CurrentWeatherViewModel {
    public func configure(_ view: CurrentWeatherView) {
        view.tempLabel.text = currentTemp + "℃"
        view.cityNameLabel.text = cityName
        view.maxMinTempLabel.text = maxMinTemp
    }
}
