//
//  CurrentWeatherView.swift
//  WeatherMVVM
//
//  Created by webwerks on 25/07/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIView {

    @IBOutlet var containtView: UIView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var maxMinTempLabel: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.commonInti()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init?(coder:) is not supported")
    }

    private func commonInti() {
        Bundle.main.loadNibNamed("CurrentWeatherView", owner: self, options: nil)
        addSubview(containtView)
        containtView.frame = self.bounds
        containtView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.tempLabel.font = UIFont(name: ProximaNovaSoftBold, size: 50)
        self.cityNameLabel.font = UIFont(name: ProximaNovaSemibold, size: 36)
        self.maxMinTempLabel.font = UIFont(name: ProximaNovaSoftRegular, size: 18)
    }
}
