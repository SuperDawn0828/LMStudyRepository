//
//  ViewController.swift
//  mask
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var backgroundImageView: UIImageView?
    var otherImageView: UIImageView?
    var masklayer: CALayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initSubviews()
        addMaskLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSubviews() {
        let bounds = UIScreen.main.bounds
        
        otherImageView = UIImageView()
        otherImageView?.image = UIImage(named: "引导页")
        otherImageView?.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        otherImageView?.center = view.center
        view.addSubview(otherImageView!)
        
        backgroundImageView = UIImageView()
        backgroundImageView?.image = UIImage(named: "引导页")
        backgroundImageView?.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        view.addSubview(backgroundImageView!)
    }

    func addMaskLayer() {
        masklayer = CALayer()
        masklayer?.backgroundColor = UIColor.white.cgColor
        masklayer?.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        masklayer?.cornerRadius = 50
        
        backgroundImageView?.layer.mask = masklayer
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let toucheSet = touches as NSSet
        let touch = toucheSet.anyObject() as! UITouch
        
        let point = touch.location(in: backgroundImageView)
        print(point)
        
        masklayer?.position = point
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let toucheSet = touches as NSSet
        let touch = toucheSet.anyObject() as! UITouch
        
        let point = touch.location(in: backgroundImageView)
        print(point)
        
        masklayer?.position = point
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }


}

