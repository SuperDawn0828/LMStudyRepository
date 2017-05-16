//
//  QRScanView.swift
//  IOSQRScanExample
//
//  Created by 黎明 on 2017/5/15.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class QRScanView: UIView {
    
    let topView = UIView()
    let bottomView = UIView()
    let leftView = UIView()
    let rightView = UIView()
    let contentView = UIView()
    let qrImageView = UIImageView()
    let lineImageView = UIImageView()
    
    
    var viewWidth: CGFloat = 0.0
    var viewHeight: CGFloat = 0.0
    var scanWidth: CGFloat = 0.0
    var scanHeight: CGFloat = 0.0
    let scale: CGFloat = 0.7
    let lineHeight: CGFloat = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewWidth = frame.width
        viewHeight = frame.height
        
        scanWidth = viewWidth * scale
        scanHeight = viewWidth * scale
        
        setupSubViews()
    }
    
    private func setupSubViews() {
        topView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        topView.frame = CGRect(x: 0.0, y: 0.0, width: viewWidth, height: (viewHeight - scanHeight) / 2.0)
        addSubview(topView)
        
        leftView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        leftView.frame = CGRect(x: 0.0, y: (viewHeight - scanHeight) / 2.0, width: (viewWidth - scanWidth) / 2.0, height: scanHeight)
        addSubview(leftView)
        
        rightView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        rightView.frame = CGRect(x: (viewWidth + scanWidth) / 2.0, y: (viewHeight - scanHeight) / 2.0, width: (viewWidth - scanWidth) / 2.0, height: scanHeight)
        addSubview(rightView)
        
        bottomView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        bottomView.frame = CGRect(x: 0.0, y: (viewHeight + scanHeight) / 2.0, width: viewWidth, height: (viewHeight - scanHeight) / 2.0)
        addSubview(bottomView)
        
        contentView.backgroundColor = .clear
        contentView.frame = CGRect(x: (viewWidth - scanWidth) / 2.0, y: (viewHeight - scanHeight) / 2.0, width: scanWidth, height: scanHeight)
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.borderWidth = 1.0
        addSubview(contentView)
        
        qrImageView.image = UIImage(named: "pick_bg")
        qrImageView.frame = CGRect(x: 0, y: 0, width: scanWidth, height: scanHeight)
        contentView.addSubview(qrImageView)
        
        lineImageView.image = UIImage(named: "line")
        lineImageView.frame = CGRect(x: 0, y: 0, width: scanWidth, height: lineHeight)
        contentView.addSubview(lineImageView)
    }
    
    public func startLineAnimation() {
        let startX = scanWidth / 2.0
        let endX = scanWidth / 2.0
        
        let startY = lineHeight / 2.0
        let endY = scanHeight - lineHeight / 2.0
        
        lineImageView.layer.removeAllAnimations()
        
        let animationPath = UIBezierPath()
        animationPath.move(to: CGPoint(x: startX, y: startY))
        animationPath.addLine(to: CGPoint(x: endX, y: endY))
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = animationPath.cgPath
        animation.duration = 2.0
        animation.autoreverses = false
        animation.repeatCount = MAXFLOAT
        lineImageView.layer.add(animation, forKey: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
