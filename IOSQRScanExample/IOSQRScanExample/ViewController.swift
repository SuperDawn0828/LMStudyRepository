//
//  ViewController.swift
//  IOSQRScanExample
//
//  Created by 黎明 on 2017/5/15.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 150, height: 50)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        let qrScanVC = QRScanViewController()
        let qrScanNav = UINavigationController(rootViewController: qrScanVC)
        present(qrScanNav, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

