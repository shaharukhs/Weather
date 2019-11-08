//
//  ForecastViewModel.swift
//  WeatherMVVM
//
//  Created by webwerks on 25/07/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class ForecastViewModel: NSObject {

    private var weatherForeCastModel: WeatherForeCastModel
    
    private var hourlyForecastView: HourlyForecastView?
    
    // we set a variable to hold the contentOffSet before scroll view scrolls
    var lastContentOffset: CGFloat = 0
        
    private let swipeUp = UISwipeGestureRecognizer() // Swipe Up gesture recognizer
    private let swipeDown = UISwipeGestureRecognizer() // Swipe Down gesture recognizer OR You can use single Swipe Gesture
    
    public init(weatherForeCastModel: WeatherForeCastModel) {
        self.weatherForeCastModel = weatherForeCastModel
    }
    
}

extension ForecastViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherForeCastModel.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyForecastTVC", for: indexPath) as? HourlyForecastTVC {
            cell.configure(weather: self.weatherForeCastModel.list?[indexPath.row])
            
            //show pulleyView on first cell only and hide to other cells
            if indexPath.row != 0 {
                cell.pulleyView.isHidden = true
            } else {
                cell.pulleyView.isHidden = false
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    /*
     //add pulley View programmatically
    private func addPulleyViewToFirstCell(cell: HourlyForecastTVC) {
        pulleyViewSetFlag = true
        let pulleyView = UIView()
        cell.contentView.addSubview(pulleyView)
        pulleyView.backgroundColor = .white
        
        pulleyView.translatesAutoresizingMaskIntoConstraints = false
        pulleyView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor).isActive = true
        pulleyView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10).isActive = true
        pulleyView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        pulleyView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        cell.contentView.layoutIfNeeded()
        pulleyView.layer.cornerRadius = pulleyView.frame.size.height/2
        pulleyView.layer.masksToBounds = true
    }
    */
    
    // this delegate is called when the scrollView (i.e your UITableView) will start scrolling
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    // while scrolling this delegate is being called so you may now check which direction your scrollView is being scrolled to
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            // did move up
//            print("tableView move up")
        } else if (self.lastContentOffset > scrollView.contentOffset.y) {
            // did move down
//            print("tableView move down")
            
            if scrollView.contentOffset.y < 0 || self.lastContentOffset == 0 {
                scrollView.isUserInteractionEnabled = false
            }
        } else {
            // didn't move
        }
    }
}

extension ForecastViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //set tableview cell height dynamic or constant, currently it's set to constant height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension ForecastViewModel {
    //default configure view for HourlyForecastView
    public func configure(_ view: HourlyForecastView) {
        self.hourlyForecastView = view
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        swipeUp.addTarget(self, action:  #selector(self.respondToSwipeGesture))
        view.addGestureRecognizer(swipeUp) // Or assign to view
        
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        swipeDown.addTarget(self, action:  #selector(self.respondToSwipeGesture))
        view.addGestureRecognizer(swipeDown) // Or assign to view
        
        if view.frame.origin.y == 0 {
            view.tableView.isUserInteractionEnabled = true
        } else {
            view.tableView.isUserInteractionEnabled = false
        }
    }
    
    //manage swipe gesture on HourlyForecastView
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if let view = gesture.view as? HourlyForecastView {
                hourlyForecastView = view
                switch swipeGesture.direction {
                case UISwipeGestureRecognizer.Direction.right:
//                    print("Swiped right")
                    break
                case UISwipeGestureRecognizer.Direction.left:
//                    print("Swiped left")
                    break
                case UISwipeGestureRecognizer.Direction.down:
//                    print("Swiped down")
                    self.addAnitmationToView(view: view, yPosition: view.frame.size.height - 250)
                
                case UISwipeGestureRecognizer.Direction.up:
//                    print("Swiped up")
                    view.tableView.isUserInteractionEnabled = true
                    self.addAnitmationToView(view: view, yPosition: 0)
                default:
                    break
                }
            }
        }
    }
    
    //Add view position change animation
    private func addAnitmationToView(view: HourlyForecastView, yPosition: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: {
            view.frame = CGRect(x: view.frame.origin.x, y: yPosition, width: view.frame.size.width, height: view.frame.size.height)
        }) { (finished) in
            if yPosition != 0 {
                view.addCornerRadius()
            } else {
                view.removeCornerRadius()
            }
        }
    }
}
