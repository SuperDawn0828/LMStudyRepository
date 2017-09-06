//
//  PhotoCapViewController.swift
//  LaoZicloudApp
//
//  Created by 黎明 on 2017/8/29.
//  Copyright © 2017年 mr123456. All rights reserved.
//

import UIKit

@objc protocol PhotoCapViewControllerDelegate: NSObjectProtocol {
    
    @objc optional func photoCapViewController(_ viewController: PhotoCapViewController, didSelectedImage image: UIImage)
    
    @objc optional func photoCapViewControllerDidCancel(_ viewController: PhotoCapViewController)
}

class PhotoCapViewController: UIViewController {
    
    private var SCREEN_WIDTH = UIScreen.main.bounds.width
    
    private var SCREEN_HEIGHT = UIScreen.main.bounds.height
    
    private var imageView: UIImageView!
    
    private var overView: UIView!
    
    private var footerView: UIView!
    
    private var cancelButton: UIButton!
    
    private var selectButton: UIButton!
    
    private var radius: CGFloat = 0.0
    
    private var circularFrame: CGRect!
    
    private var lastScale: CGFloat = 1.0
    
    private var scaleRation: CGFloat = 10.0
    
    private var originalFrame: CGRect!
    
    private var currentFrame: CGRect!
    
    weak var delegate: PhotoCapViewControllerDelegate?
    
    var image: UIImage? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        radius = (SCREEN_WIDTH - 54) / 2.0
        setupSubviews()
        setupAllGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupSubviews() {
        
        imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.bounds = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * (image!.size.height / image!.size.width))
        imageView.center = CGPoint(x: SCREEN_WIDTH / 2.0, y: SCREEN_HEIGHT / 2.0)
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        view.addSubview(imageView)
        
        originalFrame = imageView.frame
        
        footerView = UIView()
        footerView.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 45, width: SCREEN_WIDTH, height: 45)
        footerView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        view.addSubview(footerView)
        
        cancelButton = UIButton(type: .custom)
        cancelButton.frame = CGRect(x: 0, y: 0, width: 100, height: 45)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitle("取消", for: .highlighted)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        cancelButton.addTarget(self, action: #selector(clickCancelButtonAction(_:)), for: .touchUpInside)
        footerView.addSubview(cancelButton)
        
        selectButton = UIButton(type: .custom)
        selectButton.frame = CGRect(x: SCREEN_WIDTH - 100, y: 0, width: 100, height: 45)
        selectButton.setTitle("选取", for: .normal)
        selectButton.setTitle("选取", for: .highlighted)
        selectButton.setTitleColor(.white, for: .normal)
        selectButton.setTitleColor(.white, for: .normal)
        selectButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        selectButton.addTarget(self, action: #selector(clickSelectButtonAction(_:)), for: .touchUpInside)
        footerView.addSubview(selectButton)
        
        circularFrame = CGRect(x: SCREEN_WIDTH / 2.0 - radius, y: (SCREEN_HEIGHT - 45) / 2.0 - radius, width: radius * 2.0, height: radius * 2.0)
        
        overView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 45))
        overView.backgroundColor = .clear
        overView.isOpaque = false
        view.addSubview(overView)
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 45))
        path.append(UIBezierPath(arcCenter: CGPoint(x: SCREEN_WIDTH / 2.0, y: (SCREEN_HEIGHT - 45) / 2.0), radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: false))
        path.usesEvenOddFillRule = true
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillRule = kCAFillRuleEvenOdd
        layer.fillColor = UIColor.black.cgColor
        layer.opacity = 0.5
        overView.layer.addSublayer(layer)
        
        var width = imageView.bounds.width
        var height = imageView.bounds.height
        
        if height < circularFrame.size.height {
            width = (width / height) * circularFrame.size.height
            height = circularFrame.size.height
            imageView.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        }
    }
    
    private func setupAllGestureRecognizer() {
        let pinGR = UIPinchGestureRecognizer(target: self, action: #selector(handlePinGestureRecognizer(_:)))
        view.addGestureRecognizer(pinGR)
        
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(_:)))
        view.addGestureRecognizer(panGR)
    }
    
    @objc private func clickCancelButtonAction(_ sender: UIButton) {
        delegate?.photoCapViewControllerDidCancel?(self)
    }
    
    @objc private func clickSelectButtonAction(_ sender: UIButton) {
        delegate?.photoCapViewController?(self, didSelectedImage: createSmallImage())
    }
    
    @objc private func handlePinGestureRecognizer(_ pinGR: UIPinchGestureRecognizer) {
        let view = imageView
        if pinGR.state == .began || pinGR.state == .changed {
            view?.transform = imageView.transform.scaledBy(x: pinGR.scale, y: pinGR.scale)
            pinGR.scale = 1.0
        } else if pinGR.state == .ended {
            lastScale = 1.0
            let ration = view!.frame.size.width / originalFrame.width
            
            if ration > scaleRation {
                view!.frame = CGRect(x: 0, y: 0, width: originalFrame.size.width * scaleRation, height: originalFrame.size.height * scaleRation)
            } else if (view!.frame.width < circularFrame.width) && (originalFrame.width <= originalFrame.height) {
                view!.frame = handleWidthLessHieght(view!)
                view!.frame = handleScale(view!)
            } else if (view!.frame.height < circularFrame.height) && (originalFrame.height <= originalFrame.width) {
                view!.frame = handleHeightLessWidth(view!)
                view!.frame = handleScale(view!)
            } else {
                view!.frame = handleScale(view!)
            }
            
            currentFrame = view!.frame
        }
    }
    
    @objc private func handlePanGestureRecognizer(_ panGR: UIPanGestureRecognizer) {
        
        let view = imageView
        
        if panGR.state == .began || panGR.state == .changed {
            let translation = panGR.translation(in: view!.superview)
            view!.center = CGPoint(x: view!.center.x + translation.x, y: view!.center.y + translation.y)
            panGR.setTranslation(.zero, in: view!.superview)
        } else if panGR.state == .ended {
            var currentFrame = view!.frame
            
            if currentFrame.origin.x >= circularFrame.origin.x {
                currentFrame.origin.x = circularFrame.origin.x
            }
            
            if currentFrame.origin.y >= circularFrame.origin.y {
                currentFrame.origin.y = circularFrame.origin.y
            }
            
            if (currentFrame.size.width + currentFrame.origin.x) < (circularFrame.origin.x + circularFrame.size.width) {
                let moveLeftX = fabs(Double(currentFrame.size.width + currentFrame.origin.x - (circularFrame.origin.x + circularFrame.size.width)))
                currentFrame.origin.x += CGFloat(moveLeftX)
            }
            
            if (currentFrame.size.height + currentFrame.origin.y) < (circularFrame.origin.y + circularFrame.size.height) {
                let moveUpY = fabs(Double(currentFrame.size.height + currentFrame.origin.y - (circularFrame.origin.y + circularFrame.size.height)))
                currentFrame.origin.y += CGFloat(moveUpY)
            }
            
            UIView.animate(withDuration: 0.05, animations: {
                view!.frame = currentFrame
            })
        }
    }
    
    private func handleScale(_ view: UIView) -> CGRect {
        if (view.frame.origin.x + view.frame.width) < (circularFrame.origin.x + circularFrame.size.width) {
            let right = view.frame.origin.x + view.frame.width
            let space = circularFrame.origin.x + circularFrame.size.width - right
            view.frame.origin.x += space
        }
        
        if view.frame.origin.y > circularFrame.origin.y {
            view.frame.origin.y = circularFrame.origin.y
        }
        
        if view.frame.origin.x > circularFrame.origin.x {
            view.frame.origin.x = circularFrame.origin.x
        }
        
        if (view.frame.size.height + view.frame.origin.y) < (circularFrame.origin.y + circularFrame.size.height) {
            let space = circularFrame.origin.y + circularFrame.size.height - (view.frame.size.height + view.frame.origin.y)
            view.frame.origin.y += space
        }
        
        return view.frame
    }
    
    private func handleHeightLessWidth(_ view: UIView) -> CGRect {
        let tempFrame = view.frame
        let rat = originalFrame.size.width / originalFrame.size.height
        let width = circularFrame.size.width * rat
        let height = circularFrame.size.height
        var x = view.frame.origin.x
        let y = circularFrame.origin.y
        
        if view.frame.origin.x > circularFrame.origin.x {
            x = circularFrame.origin.x
        } else if (view.frame.origin.x + view.frame.size.width) < (circularFrame.origin.x + circularFrame.size.width) {
            x = circularFrame.origin.x + circularFrame.size.width - width
        }
        
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        
        if (tempFrame.origin.x > circularFrame.origin.x) && ((tempFrame.origin.x + view.frame.size.width) < (circularFrame.origin.x + circularFrame.size.width)) {
            view.center = self.view.center
        }
        
        if (tempFrame.origin.y > circularFrame.origin.x) && ((tempFrame.origin.y + tempFrame.size.height) < (circularFrame.origin.y + circularFrame.size.height)) {
            view.center = CGPoint(x: tempFrame.size.width / 2.0 + tempFrame.origin.x, y: view.frame.height / 2.0)
        }
        
        return view.frame
    }
    
    private func handleWidthLessHieght(_ view: UIView) -> CGRect {
        let tempFrame = view.frame
        let rat = originalFrame.size.height / originalFrame.size.width
        let width = circularFrame.size.width
        let height = circularFrame.size.height * rat
        let x = circularFrame.origin.x
        var y = view.frame.origin.y
        
        if view.frame.origin.y > circularFrame.origin.y {
            y = circularFrame.origin.y
        } else if (view.frame.origin.y + view.frame.size.height) < (circularFrame.origin.y + circularFrame.size.height) {
            y = circularFrame.origin.y + circularFrame.size.height - height
        }
        
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        
        if (tempFrame.origin.y > circularFrame.origin.y) && ((tempFrame.origin.y + tempFrame.size.height) < (circularFrame.origin.y + circularFrame.size.height)) {
            view.center = self.view.center
        }
        
        if (tempFrame.origin.x > circularFrame.origin.x) && ((tempFrame.origin.x + tempFrame.size.width) < (circularFrame.origin.y + circularFrame.size.width)) {
            view.center = CGPoint.init(x: view.frame.size.width / 2.0, y: tempFrame.size.height / 2.0 + tempFrame.origin.y)
        }
        
        return view.frame
    }
    
    private func createSmallImage() -> UIImage {
        let width = imageView.frame.size.width
        let rationScale = width / image!.size.width
        
        let oriX = (circularFrame.origin.x - imageView.frame.origin.x) / rationScale
        let oriY = (circularFrame.origin.y - imageView.frame.origin.y) / rationScale
        let oriWidth = circularFrame.size.width / rationScale
        let oriHeight = circularFrame.size.height / rationScale
        
        let rect = CGRect(x: oriX, y: oriY, width: oriWidth, height: oriHeight)
        let imageRef = image!.cgImage?.cropping(to: rect)
        
        UIGraphicsBeginImageContext(rect.size)
        let contenxt = UIGraphicsGetCurrentContext()
        contenxt?.draw(imageRef!, in: rect)
        let clipImage = UIImage(cgImage: imageRef!)
        UIGraphicsEndImageContext()
        
        return clipImage
    }
    
    private func circularClipImage(image: UIImage) -> UIImage {
        let arcCenterX = image.size.width / 2.0
        let arcCenterY = image.size.height / 2.0
        
        UIGraphicsBeginImageContext(image.size)
        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        context?.addArc(center: CGPoint.init(x: arcCenterX, y: arcCenterY), radius: image.size.width / 2.0, startAngle: 0.0, endAngle: CGFloat(2.0 * .pi), clockwise: false)
        context?.clip()
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
