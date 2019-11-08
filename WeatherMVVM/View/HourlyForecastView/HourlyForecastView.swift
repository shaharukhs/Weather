//
//  HourlyForecastView.swift
//  WeatherMVVM
//
//  Created by webwerks on 31/07/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class HourlyForecastView: UIView {

    @IBOutlet var containtView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
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
        Bundle.main.loadNibNamed("HourlyForecastView", owner: self, options: nil)
        addSubview(containtView)
        containtView.frame = self.bounds
        containtView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    public func addCornerRadius() {
        self.layer.cornerRadius = 20
        self.layoutIfNeeded()
        self.clipsToBounds = true
    }
    
    public func removeCornerRadius() {
        self.layer.cornerRadius = 0
        self.layoutSubviews()
        self.clipsToBounds = false
    }
    
}
