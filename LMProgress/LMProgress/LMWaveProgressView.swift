//
//  LMWaveProgressView.swift
//  LMProgress
//
//  Created by apple on 2017/4/28.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class LMWaveProgressView: UIView {

    private let backgroundView = UIView()
    
    private let cosView = UIView()
    
    private let sinViw = UIView()
    
    private let cosMaskLayer = CAShapeLayer()
    
    private let sinMaskLayer = CAShapeLayer()
    
    private var displayLink: CADisplayLink?
    
    private var waveWidth: CGFloat = 0.0
    
    private var waveHeight: CGFloat = 0.0
    
    private var frequency = 0.3
    
    private var phaseShift = 5.0
    
    private var phase = 0.0
    
    private var maxAmplitude: CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupWaveData()
        initSubviews()
        initMaskLayer()
    }
    
    private func setupWaveData() {
        let size = bounds.size
        let viewWidth = (size.width <= size.height) ? size.width : size.height
        
        
        waveWidth = viewWidth
        maxAmplitude = viewWidth * 0.1
        waveHeight = viewWidth + 2 * maxAmplitude
        frequency = 1.0 / Double(waveWidth * 3.0 / 2)
        phaseShift = 5
        
    }
    
    private func initSubviews() {
        backgroundView.backgroundColor = UIColorFromRGB(0xedeee8)
        backgroundView.bounds = CGRect(x: 0, y: 0, width: waveWidth, height: waveWidth)
        backgroundView.center = center
        backgroundView.layer.cornerRadius = waveWidth / 2.0
        backgroundView.layer.masksToBounds = true
        addSubview(backgroundView)
        
        cosView.backgroundColor = UIColorFromRGB(0xaadeaf)
        cosView.bounds = CGRect(x: 0, y: 0, width: waveWidth, height: waveWidth)
        cosView.center = center
        cosView.layer.cornerRadius = waveWidth / 2.0
        cosView.layer.masksToBounds = true
        addSubview(cosView)
        
        sinViw.backgroundColor = UIColorFromRGB(0x3daf47)
        sinViw.bounds = CGRect(x: 0, y: 0, width: waveWidth, height: waveWidth)
        sinViw.center = center
        sinViw.layer.cornerRadius = waveWidth / 2.0
        sinViw.layer.masksToBounds = true
        addSubview(sinViw)
    }
    
    private func initMaskLayer() {
        sinMaskLayer.backgroundColor = UIColor.clear.cgColor
        sinMaskLayer.frame = CGRect(x: 0, y: waveWidth, width: waveWidth, height: waveHeight)
        sinViw.layer.mask = sinMaskLayer
        
        cosMaskLayer.backgroundColor = UIColor.clear.cgColor
        cosMaskLayer.frame = CGRect(x: 0, y: waveWidth, width: waveWidth, height: waveHeight)
        cosView.layer.mask = cosMaskLayer
    }
    
    private func setupSinPath() -> UIBezierPath {
        let sinWavePath = UIBezierPath()
        
        var endX: CGFloat = 0
        for x in 0 ..< Int(waveWidth + 1) {
            
            let tmpPhase = phase * .pi / 180.0
            let tmpAngle = frequency * .pi * Double(x) * 360.0 / Double(waveWidth)
            
            let y: CGFloat = maxAmplitude * CGFloat(sin(tmpAngle + tmpPhase)) + maxAmplitude
            if x == 0 {
                sinWavePath.move(to: CGPoint(x: CGFloat(x), y: y))
            } else {
                sinWavePath.addLine(to: CGPoint(x: CGFloat(x), y: y))
            }
            
            endX = CGFloat(x)
        }
        
        let endY: CGFloat = waveHeight
        sinWavePath.addLine(to: CGPoint(x: endX, y: endY))
        sinWavePath.addLine(to: CGPoint(x: 0, y: endY))
        sinWavePath.close()
        
        return sinWavePath
    }
    
    private func setupCosPath() -> UIBezierPath {
        let cosWavepath = UIBezierPath()
        
        var endX: CGFloat = 0
        for x in 0 ..< Int(waveWidth + 1) {
            let tmpPhase = phase * .pi / 180.0
            let tmpAngle = frequency * .pi * Double(x) * 360.0 / Double(waveWidth)
            
            let y: CGFloat = maxAmplitude * CGFloat(cos(tmpAngle + tmpPhase)) + maxAmplitude
            if x == 0 {
                cosWavepath.move(to: CGPoint(x: CGFloat(x), y: y))
            } else {
                cosWavepath.addLine(to: CGPoint(x: CGFloat(x), y: y))
            }
            
            endX = CGFloat(x)
        }
        
        let endY: CGFloat = waveHeight + 10.0
        cosWavepath.addLine(to: CGPoint(x: endX, y: endY))
        cosWavepath.addLine(to: CGPoint(x: 0, y: endY))
        cosWavepath.close()
        
        return cosWavepath
    }
    
    open func startLoading() {
        displayLink?.invalidate()
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateWave(displayLink:)))
        displayLink?.add(to: RunLoop.current, forMode: .commonModes)
    }
    
    open func stopLoading() {
        
    }
    
    open func setProgress(value: CGFloat, animate: Bool) {
        
        let byPositionY = value * waveHeight
        let basePositionY = waveWidth + waveHeight / 2.0
        let position = sinMaskLayer.position
        
        sinMaskLayer.position = CGPoint(x: position.x, y: basePositionY - byPositionY)
        cosMaskLayer.position = CGPoint(x: position.x, y: basePositionY - byPositionY)
        
        print(sinMaskLayer.position)
    }
    
    @objc private func updateWave(displayLink: CADisplayLink) {
        phase += phaseShift
        
        sinMaskLayer.path = setupSinPath().cgPath
        cosMaskLayer.path = setupCosPath().cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

func UIColorFromRGB(_ value: Int) -> UIColor {
    let r: CGFloat = CGFloat((value & 0xff0000) >> 16) / 256.0
    let g: CGFloat = CGFloat((value & 0x00ff00) >> 08) / 256.0
    let b: CGFloat = CGFloat((value & 0x0000ff) >> 00) / 256.0
    
    let color = UIColor.init(red: r, green: g, blue: b, alpha: 1)
    
    return color
}
