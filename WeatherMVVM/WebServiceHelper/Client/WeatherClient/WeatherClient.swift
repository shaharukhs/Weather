//
//  WeatherClient.swift
//  WeatherMVVM
//
//  Created by Neosoft on 30/10/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import Foundation
import UIKit

class WeatherClient: RequestClient {
    static let shared = WeatherClient()
    
    /// getCurrentLocationWeather
    func getCurrentLocationWeather(query: String = "", withStatusCode statusCode: Int = 200, vc: UIViewController, completion: @escaping (Result<CurrentWeather?, APIError>) -> ()) {
        if Reachability.isConnectedToNetwork() {
            guard let request = WeatherAPI.weather.requestWithQuery(query: query) else { return }
            
            print("Request URL :: ", request.url?.absoluteString ?? "Some thing went wrong")
            self.fetch(with: request, withStatusCode: statusCode , decode: { json -> CurrentWeather? in
                guard let results = json as? CurrentWeather else { return  nil }
                return results
            }, completion: completion)
        } else {
            print("Not reachable")
            Alert.showNoInternetConnection(on: vc)
        }
    }
    
}
