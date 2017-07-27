//
//  ViewController.swift
//  Lock
//
//  Created by 黎明 on 2017/7/26.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func buttonOneAction(_ sender: UIButton) {
        __dispatch_async(DispatchQueue.global()) {
            for index in 0 ... 20 {
                sleep(5)
                UserInfo.userInfo.writeData("\(index)")
            }
            
            
            
        }
    }
    
    @IBAction func buttonTwoAction(_ sender: UIButton) {
        __dispatch_async(DispatchQueue.global()) {
            for index in 0 ... 100 {
                sleep(1)
                print("current thread: \(Thread.current), index: \(index)")
                print(UserInfo.userInfo.readData())
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

