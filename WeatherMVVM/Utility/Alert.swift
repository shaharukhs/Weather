//
//  Alert.swift
//  WeatherMVVM
//
//  Created by Neosoft on 07/11/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

enum Alert {
    static func showBasic(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(action)
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
    
    //MARK:- No Internet connection alert
    static func showNoInternetConnection(on vc: UIViewController) {
        Alert.showBasic(title: "No Internet Connection", message: "Please try again later", vc: vc)
    }
    
    static func somethingWentWrong(on vc: UIViewController) {
        Alert.showBasic(title: "Something went wrong", message: "Please try again later", vc: vc)
    }
}
