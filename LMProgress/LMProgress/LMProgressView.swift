//
//  LMProgressView.swift
//  LMProgress
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class LMProgressView: UIView {
    
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
    
    private let bezierPath: UIBezierPath = UIBezierPath()
    
    private var progress: CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBezierPath()
        setupLayers()
        
    }
    
    private func setupLayers() {
        
        let size = frame.size
        let width = (size.width <= size.height) ? size.width : size.height
        
        trackLayer.frame = CGRect(x: (size.width - width) / 2.0, y: (size.height - width) / 2.0, width: width, height: width)
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.strokeColor = trackColor.cgColor
        self.layer.addSublayer(trackLayer)
        trackLayer.path = bezierPath.cgPath
        
        progressLayer.frame = CGRect(x: (size.width - width) / 2.0, y: (size.height - width) / 2.0, width: width, height: width)
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.strokeEnd = 0.0
        self.layer.addSublayer(progressLayer)
        progressLayer.path = bezierPath.cgPath
    }
    
    private func setupBezierPath() {
        let size = frame.size
        let width = (size.width <= size.height) ? size.width : size.height
        
        let startAngle = -.pi/2.0
        let endAngle = startAngle + 2.0 * .pi
        
        bezierPath.removeAllPoints()
        bezierPath.addArc(withCenter: CGPoint(x: size.width / 2.0, y: size.height / 2.0), radius: width / 2.0, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
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
    
    private func animation(value: CGFloat) {
        
        let animationTime = Double(abs(progress - value)) * (duration)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = value
        animation.duration = animationTime
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.progressLayer.add(animation, forKey: "")
    }
    
    private func upData(value: CGFloat) {
        self.progressLayer.removeAllAnimations()
        self.progressLayer.strokeEnd = value
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
