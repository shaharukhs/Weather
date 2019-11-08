//
//  HourlyForecastTVC.swift
//  WeatherMVVM
//
//  Created by webwerks on 30/07/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit

class HourlyForecastTVC: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var pulleyView: UIView!
    
    lazy var dateFormatterForWSResponse: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    lazy var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "dd,MMM hh:mm a"
        return formatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pulleyView.layer.cornerRadius = pulleyView.frame.size.height/2
        pulleyView.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if #available(iOS 13.0, *) {
            titleLabel.textColor = .label
        } else {
            // Fallback on earlier versions
            titleLabel.textColor = .black
        } //UIColor.init(hexString: AppTextColor)
        titleLabel.font = UIFont(name: ProximaNovaSoftRegular, size: 18)
        
        tempLabel.textColor = UIColor.init(hexString: BrandColor)
        tempLabel.font = UIFont(name: ProximaNovaSemibold, size: 18)
        
        // Configure the view for the selected state
    }
    
    func configure(weather: WFList?) {
        titleLabel.text = Utility.getDateString(stringDate: (weather?.dtTxt)!, dateFormatInput: dateFormatterForWSResponse, dateFormatOutput: dateFormatter)
        tempLabel.text = String(format: "%.1f\(celSymbol)", ((weather?.main?.temp ?? 273.15) - 273.15))
    }
    
}
