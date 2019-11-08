//
//  CurrentWeatherViewController.swift
//  WeatherMVVM
//
//  Created by webwerks on 27/06/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit
import CoreLocation
import MBProgressHUD

class CurrentWeatherViewController: UIViewController {

    private var viewModel: CurrentWeatherViewModel?
    private var forecastHourlyViewModel: ForecastViewModel?
    
    var currentWeatherView = CurrentWeatherView()
    var hourlyForecastView = HourlyForecastView()
    
    var locationManager: CLLocationManager!
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        self.coreLocationSetup()
        // Do any additional setup after loading the view.
    }

    //MARK: CoreLocation intitalization
    private func coreLocationSetup() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        //Ask location permission for when in use
        locationManager.requestWhenInUseAuthorization()
    }
    
    //MARK: Get Current Weather WS
    private func fetchCurrentWeather(city: String) {
        
        let loadingNotification = Utility.addLoader(on: self)
        
        WeatherClient.shared.getCurrentLocationWeather(query: city, vc: self, completion: { (result) in
            switch result {
            case .success(let responseObj):
                //initialize CurrentWeatherViewModel
                self.viewModel = CurrentWeatherViewModel(currentWeather: responseObj!)
                self.addCurrentWeatherViews()
                
                //Call Current Forecast API once current weather is received
                self.fetchCurrentForecastHourly(city: city)
                
                DispatchQueue.main.async {
                    loadingNotification.hide(animated: true)
                }
                
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    loadingNotification.hide(animated: true)
                }
            }
        })
    }
    
    //MARK: Get Current Forecast WS
    private func fetchCurrentForecastHourly(city: String) {
        ForecastClient.shared.getCurrentLocationForecast(query: city, vc: self, completion: { (result) in
            switch result {
            case .success(let responseObj):
                //initialize ForecastViewModel
                self.forecastHourlyViewModel = ForecastViewModel(weatherForeCastModel: responseObj!)
                
                self.addHourlyForecastView()
            case .failure(let error):
                print(error)
            }
        })
    }

    //MARK: Add Current Weather View to parent view
    private func addCurrentWeatherViews() {
        //init homeView
        currentWeatherView = CurrentWeatherView.init(frame: self.view.bounds)
        
        //Add the view
        self.view.addSubview(currentWeatherView)
        
        //assign value to views label or other stuff
        viewModel?.configure(currentWeatherView)
    }
    
    //MARK: add hourly forecast view
    private func addHourlyForecastView() {
        //initialize hourly forecast view
        hourlyForecastView = HourlyForecastView.init(frame: self.view.bounds)
        
        //add subview to view
        self.view.addSubview(hourlyForecastView)
        
        //change Y postion of hourly forecast view on intial load
        hourlyForecastView.frame = CGRect(x: 0, y: self.hourlyForecastView.frame.size.height - 250, width: self.hourlyForecastView.frame.size.width, height: self.hourlyForecastView.frame.size.height)
        
        hourlyForecastView.addCornerRadius()
        
        //add table view datasource and delegate to correponding viewModel
        self.addTableViewData()
        
        //configure hourly forecast view
        forecastHourlyViewModel?.configure(hourlyForecastView)
    }
    
    
    //MARK:- TableView Set DataSource and Delegate
    //Tableview MVVM refere link
    //https://github.com/takumi314/Sample-TableView-With-MultipleCell-MVVM
    
    private func addTableViewData() {
        self.hourlyForecastView.tableView.dataSource = forecastHourlyViewModel
        self.hourlyForecastView.tableView.delegate = forecastHourlyViewModel
        self.hourlyForecastView.tableView.estimatedRowHeight = 100
        self.hourlyForecastView.tableView.rowHeight = UITableView.automaticDimension
        
        self.hourlyForecastView.tableView.register(UINib(nibName: "HourlyForecastTVC", bundle: nil), forCellReuseIdentifier: "HourlyForecastTVC")
    }
}

extension CurrentWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations = \(locations)")
        self.locationManager.stopUpdatingLocation()
        
        if locations.count > 0 {
            if Reachability.isConnectedToNetwork() {
                let loadingNotification = Utility.addLoader(on: self)
                let geoCoder = CLGeocoder()
                let location = CLLocation(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
                geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error -> Void in
                    // Place details
                    
                    DispatchQueue.main.async {
                        loadingNotification.hide(animated: true)
                    }
                    
                    guard let placeMark = placemarks?.first else { return }
                    
                    // City
                    if let city = placeMark.subAdministrativeArea {
                        print(city)
                        self.fetchCurrentWeather(city: city)
                        
                    }
                    // Country
                    if let country = placeMark.country {
                        print(country)
                    }
                    
                })
            } else {
                Alert.somethingWentWrong(on: self)
            }
        }
    }
}
