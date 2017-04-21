//
//  LMCircleSpinner.swift
//  LMHud
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class LMCircleSpinner: UIView {
    
    open var animationDuratrion: TimeInterval = 1.5
    
    open var isClockWise: Bool = false
    
    open var lineColor: UIColor = .white
    
    open var lineWidth: CGFloat = 2 * HUDSCALE {
        didSet {
            cirleShapelayer?.path = circlePath().cgPath
            setupArc()
            startAnimation()
        }
    }
    
    private var cirleShapelayer: CAShapeLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        initViews()
        setupArc()
        startAnimation()
    }
    
    private func initViews() {
        let viewWidth = bounds.width
        let viewHeight = bounds.height
        let centerPoint = CGPoint(x: viewWidth / 2.0, y: viewHeight / 2.0)
        
        cirleShapelayer = CAShapeLayer()
        cirleShapelayer?.path = circlePath().cgPath
        cirleShapelayer?.frame = bounds
        cirleShapelayer?.position = centerPoint
        cirleShapelayer?.strokeColor = lineColor.cgColor
        cirleShapelayer?.lineWidth = lineWidth
        cirleShapelayer?.lineCap = "round"
        cirleShapelayer?.backgroundColor = UIColor.clear.cgColor
        cirleShapelayer?.fillColor = UIColor.clear.cgColor
        cirleShapelayer?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        layer.addSublayer(cirleShapelayer!)
    }
    
    private func setupArc() {
        cirleShapelayer?.strokeStart = 0.05
        cirleShapelayer?.strokeEnd = 0.9
    }
    
    private func startAnimation() {
        cirleShapelayer?.removeAllAnimations()
        
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animation.duration = animationDuratrion
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        if isClockWise {
            animation.fromValue = 0
            animation.toValue = 2.0 * .pi
        } else {
            animation.fromValue = 2.0 * .pi
            animation.toValue = 0
        }
        
        cirleShapelayer?.add(animation, forKey: "cirleAnimation")
    }
    
    private func circlePath() -> UIBezierPath {
        let viewWidth = bounds.width
        let viewHeight = bounds.height
        let raduis = fmax(viewWidth, viewHeight)
        let centerPoint = CGPoint(x: viewWidth / 2.0, y: viewHeight / 2.0)
        let lineWidth = self.lineWidth
        
        let arcPath = UIBezierPath.init(arcCenter: centerPoint, radius: (raduis - lineWidth) / 2.0, startAngle: 0, endAngle: CGFloat(2.0 * .pi), clockwise: false)
        arcPath.lineCapStyle = .round
        return arcPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
