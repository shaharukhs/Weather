//
//  CurrentWeather.swift
//  WeatherMVVM
//
//  Created by webwerks on 27/06/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import Foundation

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    let coord: CWCoord?
    let weather: [CWWeather]?
    let base: String? //Internal parameter
    let main: CWMain?
    let visibility: Int?
    let wind: CWWind?
    let clouds: CWClouds?
    let rain, snow: CWRain?
    let dt: Int? //Time of data calculation, unix, UTC
    let sys: CWSys?
    let timezone: Int? //Shift in seconds from UTC
    let id: Int? //City ID
    let name: String? //City name
    let cod: Int? // Internal parameter
}

// MARK: - Clouds
struct CWClouds: Codable {
    let all: Int? // Cloudiness, %
}

// MARK: - Coord
struct CWCoord: Codable {
    let lon, lat: Double? //City geo location, longitude and latitude
}

// MARK: - Main
struct CWMain: Codable {
    let temp: Double? //Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    let pressure: Int? //Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
    let humidity: Int? //Humidity, %
    let tempMin, tempMax: Double? //Minimum/Maximum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    let seaLevel: Double? //Atmospheric pressure on the sea level, hPa
    let grndLevel : Double? //Atmospheric pressure on the ground level, hPa
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

// MARK: - Rain
struct CWRain: Codable {
    let the1D, the3D: Int? //Rain/Snow volume for the last 1/3 day(s), mm
    
    enum CodingKeys: String, CodingKey {
        case the1D = "1d"
        case the3D = "3d"
    }
}

// MARK: - Sys
struct CWSys: Codable {
    let type, id: Int? //Internal parameter
    let message: Double? // Internal parameter
    let country: String? //Country code (GB, JP etc.)
    let sunrise, sunset: Int? // Sunrise/Sunset time, unix, UTC
}

// MARK: - Weather
struct CWWeather: Codable {
    let id: Int? //Weather condition id
    let main: String? //Group of weather parameters (Rain, Snow, Extreme etc.)
    let weatherDescription: String? //Weather condition within the group
    let icon: String? //Weather icon id
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct CWWind: Codable {
    let speed: Double? //Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour.
    let deg: Int? //Wind direction, degrees (meteorological)
}
