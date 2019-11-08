//
//  Utility.swift
//  WeatherMVVM
//
//  Created by webwerks on 31/07/19.
//  Copyright © 2019 webwerks. All rights reserved.
//

import UIKit
import MBProgressHUD

class Utility: NSObject {
    class func getDateString(stringDate: String, dateFormatInput:DateFormatter, dateFormatOutput: DateFormatter) -> String {
        let date = dateFormatInput.date(from: stringDate)
        print("Date from response :: ",date as Any)
        let dateString = dateFormatOutput.string(from: date!)
        return dateString
    }
    
    class func addLoader(on vc: UIViewController) -> MBProgressHUD {
        let loadingNotification = MBProgressHUD.showAdded(to: vc.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
        return loadingNotification
    }
}
