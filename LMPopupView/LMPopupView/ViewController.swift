//
//  ViewController.swift
//  LMPopupView
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        view.addSubview(button)
        
        let button1 = UIButton()
        button1.frame = CGRect(x: 100, y: 200, width: 100, height: 50)
        button1.backgroundColor = .red
        button1.addTarget(self, action: #selector(buttonAction1(sender:)), for: .touchUpInside)
        view.addSubview(button1)
        
        let button2 = UIButton()
        button2.frame = CGRect(x: 100, y: 300 , width: 100, height: 50)
        button2.backgroundColor = .red
        button2.addTarget(self, action: #selector(buttonAction2(sender:)), for: .touchUpInside)
        view.addSubview(button2)
    }
    
    @objc private func buttonAction(sender: UIButton) {
        let cancelAction = LMPopupAction("cancel", .normal) { (index) in
            print(index)
        }
        
        let certainAction = LMPopupAction("certain", .normal) { (index) in
            print(index)
        }
//
//        let threeAction = LMPopupAction("certain", .normal) { (index) in
//            print(index)
//        }
        
//        let alertView = LMAlertView.init(title: "test", detail: "dkfjdlkfjlkasdjf", actions: [cancelAction])
        let alertView = LMAlertView.init(title: "test", detail: "89879878797978979879879878978797879798797", placeholder: "kdljflkdjflkas", actions: [cancelAction, certainAction]) { (string) in
            
        }
        alertView.show()
    }
    
    @objc private func buttonAction1(sender: UIButton) {
        let bounds = UIScreen.main.bounds
        let sheetView = LMSheetView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 200))
        sheetView.backgroundColor = .white
        sheetView.show()
    }
    
    @objc private func buttonAction2(sender: UIButton) {
        let customView = LMCustomView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        customView.backgroundColor = .white
        customView.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

