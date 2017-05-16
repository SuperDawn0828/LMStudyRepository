//
//  TodayViewController.swift
//  IOSDateWidget
//
//  Created by 黎明 on 2017/5/15.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBOutlet weak var weekLabel: UILabel!
    
    @IBOutlet weak var clickButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            preferredContentSize = CGSize(width: maxSize.width, height: 100)
        } else {
            preferredContentSize = CGSize(width: maxSize.width, height: 200)
        }
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        let userDefault = UserDefaults.init(suiteName: "group.IOSWidgetExample")
        let value = userDefault?.value(forKey: "group.IOSWidgetExample")
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        
        guard let switchValue = value as? Bool else {
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
            dateLabel.text = dateString
            
            dateFormatter.dateFormat = "HH:mm:ss"
            let timeSting = dateFormatter.string(from: date)
            timeLabel.text = timeSting
            
            dateFormatter.dateFormat = "EEEE"
            let weekSting = dateFormatter.string(from: date)
            weekLabel.text = weekSting
            
            return
        }
        
        if switchValue {
            dateFormatter.dateFormat = "yyyy年MM月dd日"
            let dateString = dateFormatter.string(from: date)
            dateLabel.text = dateString
            
            dateFormatter.dateFormat = "HH时mm分ss秒"
            let timeSting = dateFormatter.string(from: date)
            timeLabel.text = timeSting
            
            dateFormatter.dateFormat = "EEE"
            let weekSting = dateFormatter.string(from: date)
            weekLabel.text = weekSting
            
        } else {
            dateFormatter.dateFormat = "yyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
            dateLabel.text = dateString
            
            dateFormatter.dateFormat = "HH:mm:ss"
            let timeSting = dateFormatter.string(from: date)
            timeLabel.text = timeSting
            
            dateFormatter.dateFormat = "EEEE"
            let weekSting = dateFormatter.string(from: date)
            weekLabel.text = weekSting
        }

        completionHandler(NCUpdateResult.newData)
    }
    
    @IBAction func clickButtonAction(_ sender: UIButton) {
        extensionContext?.open(URL(string: "IOSWidgetExample://")!, completionHandler: { (success) in
            
        })
        
    }
    
    
}
