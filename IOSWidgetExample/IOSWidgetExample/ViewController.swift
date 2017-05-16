//
//  ViewController.swift
//  IOSWidgetExample
//
//  Created by 黎明 on 2017/5/15.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var clickNumberLabel: UILabel!
    
    @IBOutlet weak var onSwitch: UISwitch!
    
    var clickNumber = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        clickNumberLabel.text = "click number is: \(clickNumber)"
        
        let userDefault = UserDefaults.init(suiteName: "group.IOSWidgetExample")
        let value = userDefault?.value(forKey: "group.IOSWidgetExample")
        if let switchValue = value as? Bool {
            onSwitch.isOn = switchValue
        }
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(widgetOpenAppAction(_:)), name: WidgetOpenAppNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: WidgetOpenAppNotification, object: nil)
    }
    
    @objc private func widgetOpenAppAction(_ notification: Notification) {
        clickNumber += 1
        clickNumberLabel.text = "click number is: \(clickNumber)"
    }
    
    @IBAction func onSwitchAction(_ sender: UISwitch) {
        
        let userDefault = UserDefaults.init(suiteName: "group.IOSWidgetExample")
        let value = sender.isOn
        userDefault?.set(value, forKey: "group.IOSWidgetExample")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

