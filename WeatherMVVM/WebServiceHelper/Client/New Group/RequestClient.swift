//
//  RequestClient.swift
//  WeatherMVVM
//
//  Created by webwerks on 27/06/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import Foundation

// https://medium.com/@jamesrochabrun/protocol-based-generic-networking-part-2-jsonencoder-and-encodable-for-post-request-in-swift-27ebd301c314

class RequestClient: GenericAPIClient {
        
    internal let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
}

enum WeatherAPI {
    case weather
    case forecast
}

extension WeatherAPI: Endpoint {
    var path: String {
        switch self {
        case .weather: return "/weather"
        case .forecast: return "/forecast"
        }
    }
    
    var base: String {
        return "https://api.openweathermap.org/data/2.5"
    }
}
