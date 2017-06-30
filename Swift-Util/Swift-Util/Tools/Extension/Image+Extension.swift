//
//  ImageHelper.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/9.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func image(by tintColor: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(tintColor.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func image(by tintColor: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(tintColor.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func capture(from view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        if let _ = context {
            view.layer.render(in: context!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        } else {
            return nil
        }
    }
    
    func scaleAndRatate(_ size: CGSize) -> UIImage? {
        let maxWidth = size.width
        let maxHeight = size.height
        
        let cgImage = self.cgImage
        
        if let imgRef = cgImage {
            let width = CGFloat(imgRef.width)
            let height = CGFloat(imgRef.height)
            
            var transform = CGAffineTransform.identity
            
            var bounds = CGRect.init(x: 0, y: 0, width: width, height: height)
            
            if width > maxWidth || height > maxHeight {
                let maxRatio = maxWidth / maxHeight
                let ratio = width / height
                if ratio > maxRatio {
                    bounds.size.width = maxWidth
                    bounds.size.height = bounds.size.width / ratio
                } else {
                    bounds.size.height = maxHeight
                    bounds.size.width = bounds.size.height * ratio
                }
            }
            
            let scaleRatio = bounds.size.width / width
            
            let imageSize = CGSize.init(width: width, height: height)
            var boundHeight: CGFloat = 0.0
            let orient = self.imageOrientation
            switch orient {
            case .up:
                transform = CGAffineTransform.identity
            case .upMirrored:
                transform = CGAffineTransform(translationX: imageSize.width, y: 0)
                transform = transform.scaledBy(x: -1.0, y: 1.0)
            case .down:
                transform = CGAffineTransform(translationX: imageSize.width, y: imageSize.height)
                transform = transform.rotated(by: .pi)
            case .downMirrored:
                transform = CGAffineTransform(translationX: 0.0, y: imageSize.height)
                transform = transform.scaledBy(x: 1.0, y: -1.0)
            case .leftMirrored:
                boundHeight = bounds.size.height
                bounds.size.height = bounds.size.width
                bounds.size.width = boundHeight
                transform = CGAffineTransform(translationX: imageSize.height, y: imageSize.width)
                transform = transform.scaledBy(x: -1.0, y: 1.0)
                transform = transform.rotated(by: 3.0 * .pi / 2.0)
            case .left:
                boundHeight = bounds.size.height
                bounds.size.height = bounds.size.width
                bounds.size.width = boundHeight
                transform = CGAffineTransform(translationX: 0.0, y: imageSize.width)
                transform = transform.rotated(by: 3.0 * .pi / 2.0)
            case .rightMirrored:
                boundHeight = bounds.size.height
                bounds.size.height = bounds.size.width
                bounds.size.width = boundHeight
                transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                transform = transform.rotated(by: .pi / 2.0)
            case .right:
                boundHeight = bounds.size.height
                bounds.size.height = bounds.size.width
                bounds.size.width = boundHeight
                transform = CGAffineTransform(translationX: imageSize.height, y: 0.0)
                transform = transform.rotated(by: .pi / 2.0)
            }
            
            UIGraphicsBeginImageContext(bounds.size)
            
            let context = UIGraphicsGetCurrentContext()
            
            if orient == .right || orient == .left {
                context?.scaleBy(x: -scaleRatio, y: scaleRatio)
                context?.translateBy(x: -height, y: 0)
            } else {
                context?.scaleBy(x: scaleRatio, y: -scaleRatio)
                context?.translateBy(x: 0, y: -height)
            }
            
            context?.concatenate(transform)
            
            context?.draw(imgRef, in: CGRect(x: 0, y: 0, width: width, height: height))
            let imageCopy = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return imageCopy
        } else {
            return nil
        } 
    }
}
