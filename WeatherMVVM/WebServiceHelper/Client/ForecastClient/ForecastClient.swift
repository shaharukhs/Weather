//
//  ForecastClient.swift
//  WeatherMVVM
//
//  Created by Neosoft on 30/10/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import Foundation
import UIKit

class ForecastClient: RequestClient {
    static let shared = ForecastClient()
    
    /// getCurrentLocationForecastHourly
    func getCurrentLocationForecast(query: String = "", withStatusCode statusCode: Int = 200, vc: UIViewController, completion: @escaping (Result<WeatherForeCastModel?, APIError>) -> ()) {
        
        if Reachability.isConnectedToNetwork() {
            guard let request = WeatherAPI.forecast.requestWithQuery(query: query) else { return }
            
            print("Request URL :: ", request.url?.absoluteString ?? "Some thing went wrong")
            self.fetch(with: request, withStatusCode: statusCode , decode: { json -> WeatherForeCastModel? in
                guard let results = json as? WeatherForeCastModel else { return  nil }
                return results
            }, completion: completion)
        } else {
            print("Not reachable")
            Alert.showNoInternetConnection(on: vc)
        }
    }
}
