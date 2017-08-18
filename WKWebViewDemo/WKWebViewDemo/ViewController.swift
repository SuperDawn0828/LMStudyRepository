//
//  ViewController.swift
//  WKWebViewDemo
//
//  Created by 黎明 on 2017/8/15.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func buttonAction(_ sender: UIButton) {
        let webViewVC = WebViewViewController()
        navigationController?.pushViewController(webViewVC, animated: true)
    }
    


}

