//
//  LMOtherProgressView.swift
//  LMProgress
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class LMOtherProgressView: UIView {
    open var duration: Double = 0
    
    open var lineWidth: CGFloat = 1.0 {
        didSet {
            progressLayer.lineWidth = lineWidth
            trackLayer.lineWidth = lineWidth
        }
    }
    
    open var trackColor: UIColor = .gray {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    open var progressColor: UIColor = .blue {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    private let trackLayer: CAShapeLayer = CAShapeLayer()
    
    private let progressLayer: CAShapeLayer = CAShapeLayer()
    
    private let circleLayer: CAShapeLayer = CAShapeLayer()
    
    private let bezierPath: UIBezierPath = UIBezierPath()
    
    private let circlePath: UIBezierPath = UIBezierPath()
    
    private let circleWidth: CGFloat = 6.0
    
    private var circleAngle = -.pi / 2.0
    
    private var progress: CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBezierPath()
        setupLayers()
        
    }
    
    private func setupLayers() {
        
        let size = frame.size
        let width = (size.width <= size.height) ? size.width : size.height
        
        let circleX = size.width / 2.0
        let circleY = (size.height - width) / 2.0
        
        trackLayer.frame = CGRect(x: (size.width - width) / 2.0, y: (size.height - width) / 2.0, width: width, height: width)
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.strokeColor = trackColor.cgColor
        layer.addSublayer(trackLayer)
        trackLayer.path = bezierPath.cgPath
        
        progressLayer.frame = CGRect(x: (size.width - width) / 2.0, y: (size.height - width) / 2.0, width: width, height: width)
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.strokeEnd = 0.0
        layer.addSublayer(progressLayer)
        progressLayer.path = bezierPath.cgPath
        
        circleLayer.position = CGPoint(x: circleX, y: circleY)
        circleLayer.bounds = CGRect(x: 0, y: 0, width: circleWidth, height: circleWidth)
        circleLayer.cornerRadius = circleWidth / 2.0
        circleLayer.backgroundColor = UIColor.blue.cgColor
        layer.addSublayer(circleLayer)
        
    }
    
    private func setupBezierPath() {
        let size = frame.size
        let width = (size.width <= size.height) ? size.width : size.height
        
        let startAngle = -.pi/2.0
        let endAngle = startAngle + 2.0 * .pi
        
        bezierPath.removeAllPoints()
        bezierPath.addArc(withCenter: CGPoint(x: size.width / 2.0, y: size.height / 2.0), radius: width / 2.0, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
    }
    
    private func circleLayerAnimationPath(value: CGFloat) -> UIBezierPath {
        let size = frame.size
        let width = (size.width <= size.height) ? size.width : size.height
        
        let startAngle = circleAngle
        circleAngle = -.pi / 2.0 + Double(value) * 2.0 * .pi
        
        circlePath.removeAllPoints()
        circlePath.addArc(withCenter: CGPoint(x: size.width / 2.0, y: size.height / 2.0), radius: width / 2.0, startAngle: CGFloat(startAngle), endAngle: CGFloat(circleAngle), clockwise: true)
        return circlePath
    }
    
    private func circlePosition(value: CGFloat) -> CGPoint {
        let size = frame.size
        let width = (size.width <= size.height) ? size.width : size.height
        
        let startAngle = .pi / 2.0
        let endAngle = startAngle - Double(value) * 2.0 * .pi
        
        let x = size.width / 2.0 + CGFloat(cos(endAngle)) * width / 2.0
        let y = size.height / 2.0 - CGFloat(sin(endAngle)) * width / 2.0
        
        return CGPoint(x: x, y: y)
    }
    
    private func animation(value: CGFloat) {
        let animationTime = Double(abs(progress - value)) * (duration)
        
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanFalse, forKey: kCATransactionDisableActions)
        CATransaction.setAnimationDuration(animationTime)
        self.progressLayer.strokeEnd = value
        CATransaction.commit()
        
        let baseAnimation = CAKeyframeAnimation(keyPath: "position")
        baseAnimation.path = circleLayerAnimationPath(value: value).cgPath
        baseAnimation.isRemovedOnCompletion = false
        baseAnimation.fillMode = kCAFillModeForwards
        baseAnimation.duration = animationTime
        self.circleLayer.add(baseAnimation, forKey: "")
        
    }
    
    private func upData(value: CGFloat) {
        circleLayer.removeAllAnimations()
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        progressLayer.strokeEnd = value
        circleLayer.position = circlePosition(value: value)
        CATransaction.commit()
    }
    
    open func setProgress(value: CGFloat, animated: Bool) {
        
        if progress > 1 || progress == value {
            return
        }
        
        if animated {
            animation(value: value)
        } else {
            upData(value: value)
        }
        
        progress = value
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
