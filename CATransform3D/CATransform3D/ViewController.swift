//
//  ViewController.swift
//  CATransform3D
//
//  Created by 黎明 on 2017/7/15.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var diceView: UIView!
    
    private var angle = CGPoint(x: 0, y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var transform = CATransform3DIdentity
        
        diceView = UIView()
        diceView.backgroundColor = .blue
        diceView.center = view.center
        diceView.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        view.addSubview(diceView)
        
        let dice1 = UIImageView()
        dice1.image = UIImage(named: "dice1")
        dice1.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        transform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, 50)
        dice1.layer.transform = transform
        diceView.addSubview(dice1)
        
        let dice6 = UIImageView()
        dice6.image = UIImage(named: "dice6")
        dice6.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        transform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, -50)
        dice6.layer.transform = transform
        diceView.addSubview(dice6)
        
        let dice2 = UIImageView()
        dice2.image = UIImage(named: "dice2")
        dice2.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        transform = CATransform3DRotate(CATransform3DIdentity, .pi / 2.0, 0, 1, 0)
        transform = CATransform3DTranslate(transform, 0, 0, 50)
        dice2.layer.transform = transform
        diceView.addSubview(dice2)
        
        let dice5 = UIImageView()
        dice5.image = UIImage(named: "dice5")
        dice5.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        transform = CATransform3DRotate(CATransform3DIdentity, -.pi / 2.0, 0, 1, 0)
        transform = CATransform3DTranslate(transform, 0, 0, 50)
        dice5.layer.transform = transform
        diceView.addSubview(dice5)
        
        let dice3 = UIImageView()
        dice3.image = UIImage(named: "dice3")
        dice3.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        transform = CATransform3DRotate(CATransform3DIdentity, .pi / 2.0, 1, 0, 0)
        transform = CATransform3DTranslate(transform, 0, 0, 50)
        dice3.layer.transform = transform
        diceView.addSubview(dice3)
        
        let dice4 = UIImageView()
        dice4.image = UIImage(named: "dice4")
        dice4.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        transform = CATransform3DRotate(CATransform3DIdentity, -.pi / 2.0, 1, 0, 0)
        transform = CATransform3DTranslate(transform, 0, 0, 50)
        dice4.layer.transform = transform
        diceView.addSubview(dice4)
        
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(viewTransform(_:)))
        diceView.addGestureRecognizer(panGR)
    }
    
    @objc private func viewTransform(_ gr: UIPanGestureRecognizer) {
        let point = gr.translation(in: diceView)
        let angleX = angle.x + point.x / 50.0
        let angleY = angle.y + point.y / 50.0
        
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500.0
        transform = CATransform3DRotate(transform, angleX, 0, 1, 0)
        transform = CATransform3DRotate(transform, angleY, 1, 0, 0)
        diceView.layer.sublayerTransform = transform
        
        if gr.state == .ended {
            angle.x = angleX
            angle.y = angleY
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

