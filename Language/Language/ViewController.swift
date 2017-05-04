//
//  ViewController.swift
//  Language
//
//  Created by apple on 2017/5/4.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.center = view.center
        label.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        label.textAlignment = .center
        label.textColor = .black
        label.text = NSLocalizedString("HOME", comment: "家")
        view.addSubview(label)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

