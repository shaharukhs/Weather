//
//  ViewController.swift
//  WeatherMVVM
//
//  Created by webwerks on 27/06/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    //MARK:- HomeViewController Push View
    @IBAction func currentWeatherAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CurrentWeatherViewController") as! CurrentWeatherViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func weekWeatherAction(_ sender: Any) {
        
    }
}

