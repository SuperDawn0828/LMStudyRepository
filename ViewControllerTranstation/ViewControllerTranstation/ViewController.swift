//
//  ViewController.swift
//  ViewControllerTranstation
//
//  Created by 黎明 on 2017/8/11.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let transtationDelegate = TranstationDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        let backgroundVC = BackgroundViewController()
        backgroundVC.transitioningDelegate = transtationDelegate
        backgroundVC.modalPresentationStyle = .custom
        self.present(backgroundVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

