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
        
        let otherAction = LMPopupAction("other", .normal) { (index) in
            print(index)
        }

        let alertView = LMAlertView.init(title: "谈到看到健康的健康", detail: "这是一个打底裤解放路大姐夫", placeholder: "看得见风科技的开发角度看", actions: [cancelAction, certainAction, otherAction]) { (string) in
            print(string!)
        }
        alertView.show()
    }
    
    @objc private func buttonAction1(sender: UIButton) {

        let oneAction = LMPopupAction.init("oneaction", .normal) { (index) in
            print(index)
        }
        
        let twoAction = LMPopupAction.init("twoaction", .normal) { (index) in
            print(index)
        }
        
        let threeAction = LMPopupAction.init("threeaction", .normal) { (index) in
            
        }
        
        let sheetView = LMSheetView.init(title: "测试代码", actions: [oneAction, twoAction, threeAction], cancelHandler: nil)
        sheetView.show()
    }
    
    @objc private func buttonAction2(sender: UIButton) {
        let cancelAction = LMPopupAction("cancel", .normal) { (index) in
            print(index)
        }
        
        let certainAction = LMPopupAction("certain", .normal) { (index) in
            print(index)
        }
        
        let customView = LMCustomView(title: "dfkdjfkdjfk", detail: "dkjfkdjfkdjk", actions: [cancelAction, certainAction])
        
        customView.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

