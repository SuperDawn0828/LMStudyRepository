//
//  ViewController.swift
//  LMProgress
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var progressView: LMProgressView?
    
    private var otherProgressView: LMOtherProgressView?
    
    private var waveProgressView: LMWaveProgressView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("--------\(sin(180.0 / .pi))-------")
        
        progressView = LMProgressView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        progressView?.progressColor = .blue
        progressView?.lineWidth = 10
        view.addSubview(progressView!)
        
        let button = UIButton()
        button.frame = CGRect(x : 200, y: 0, width: 100, height: 50)
        button.addTarget(self, action: #selector(buttonAction(button:)), for: .touchUpInside)
        button.backgroundColor = .red
        view.addSubview(button)
        
        let slider = UISlider(frame: CGRect(x: 50, y: 400, width: 300, height: 50))
        slider.addTarget(self, action: #selector(sliderAction(slider:)), for: .valueChanged)
        view.addSubview(slider)
        
        otherProgressView = LMOtherProgressView(frame: CGRect(x: 100, y: 500, width: 100, height: 100))
        otherProgressView?.progressColor = .blue
        otherProgressView?.lineWidth = 1
        view.addSubview(otherProgressView!)
        
        
        waveProgressView = LMWaveProgressView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        waveProgressView?.startLoading()
        view.addSubview(waveProgressView!)
    }
    
    @objc private func sliderAction(slider: UISlider) {
//        otherProgressView?.setProgress(value: CGFloat(slider.value), animated: false)
        waveProgressView?.setProgress(value: CGFloat(slider.value), animate: false)
    }
    
    @objc private func buttonAction(button: UIButton) {
        otherProgressView?.setProgress(value: 0.5, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

