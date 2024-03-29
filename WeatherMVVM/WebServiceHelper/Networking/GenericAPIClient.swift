//
//  GenericAPIClient.swift
//  WeatherMVVM
//
//  Created by webwerks on 27/06/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import Foundation

/// Generic client to avoid rewrite URL session code
protocol GenericAPIClient {
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, withStatusCode statusCode: Int, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
}

extension GenericAPIClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    private func decodingTask<T: Decodable>(with request: URLRequest, withStatusCode statusCode: Int, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed(description: error?.localizedDescription ?? "No description"))
                return
            }
            
            guard httpResponse.statusCode == statusCode else {
                completion(nil, .responseUnsuccessful(description: "\(httpResponse.statusCode)"))
                return
            }
            
            guard let data = data else { completion(nil, .invalidData); return }
            
            do {
                let stringResponse: String = String(data: data, encoding: .utf8)!
                print("String response :: ", stringResponse)
                let genericModel = try JSONDecoder().decode(decodingType, from: data)
                completion(genericModel, nil)
            } catch let err {
                completion(nil, .jsonConversionFailure(description: "\(err.localizedDescription)"))
            }
        }
        return task
    }
    
    /// success respone executed on main thread.
    func fetch<T: Decodable>(with request: URLRequest, withStatusCode statusCode: Int, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        let task = decodingTask(with: request, withStatusCode: statusCode, decodingType: T.self) { (json , error) in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    error != nil ? completion(.failure(.decodingTaskFailure(description: "\(String(describing: error))"))) : completion(.failure(.invalidData))
                    return
                }
                guard let value = decode(json) else { completion(.failure(.jsonDecodingFailure)); return }
                completion(.success(value))
            }
        }
        task.resume()
    }
}
