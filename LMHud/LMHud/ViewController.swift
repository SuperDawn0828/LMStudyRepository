//
//  ViewController.swift
//  LMHud
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let oneButton = UIButton()
        oneButton.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        oneButton.backgroundColor = .red
        oneButton.addTarget(self, action: #selector(oneButtonAction), for: .touchUpInside)
        view.addSubview(oneButton)
        
        let twoButton = UIButton()
        twoButton.frame = CGRect(x: 100, y: 200, width: 100, height: 50)
        twoButton.backgroundColor = .red
        twoButton.addTarget(self, action: #selector(twoButtonAction), for: .touchUpInside)
        view.addSubview(twoButton)
        
        let threeButton = UIButton()
        threeButton.frame = CGRect(x: 100, y: 300, width: 100, height: 50)
        threeButton.backgroundColor = .red
        threeButton.addTarget(self, action: #selector(threeButtonAction), for: .touchUpInside)
        view.addSubview(threeButton)
        
    }
    
    @objc private func oneButtonAction() {
        showWaitingHud()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            dismissWaitingHud()
        }
    }
    
    @objc private func twoButtonAction() {
        showQuickTips(title: "网络不给力")
    }

    @objc private func threeButtonAction() {
        showQuickTips(title: "网络请求错误", inView: view)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

