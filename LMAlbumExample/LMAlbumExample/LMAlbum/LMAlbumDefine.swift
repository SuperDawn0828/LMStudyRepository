//
//  LMAlbumDefine.swift
//  LMAlbumExample
//
//  Created by 黎明 on 2017/5/18.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

func albumAnimation<T: UIView>(view: T) {
    let animation = CAKeyframeAnimation(keyPath: "transform")
    animation.duration = 0.5
    var values: [CATransform3D] = []
    values.append(CATransform3DMakeScale(0.1, 0.1, 1.0))
    values.append(CATransform3DMakeScale(1.2, 1.2, 1.0))
    values.append(CATransform3DMakeScale(0.9, 0.9, 1.0))
    values.append(CATransform3DMakeScale(1.0, 1.0, 1.0))
    animation.values = values
    view.layer.add(animation, forKey: nil)
}

func albumSelectedShowAlert(_ number: Int) {
    let alertView = UIAlertController(title: nil, message: "最多可选择\(number)张图片", preferredStyle: .alert)
    let certainAction = UIAlertAction(title: "确定", style: .default, handler: nil)
    alertView.addAction(certainAction)
    
    let currentVC = getCurrentViewController()
    currentVC?.present(alertView, animated: true, completion: nil)
}

func getCurrentViewController() -> UIViewController? {
    var result: UIViewController?
    var window = UIApplication.shared.keyWindow
    
    if window?.windowLevel != UIWindowLevelNormal {
        let windows = UIApplication.shared.windows
        for tmpWindow in windows {
            if tmpWindow.windowLevel == UIWindowLevelNormal {
                window = tmpWindow
                break
            }
        }
    }
    
    let frontView = window?.subviews.first
    let nextResponder = frontView?.next
    
    if nextResponder is UIViewController {
        result = nextResponder as? UIViewController
    } else {
        result = window?.rootViewController
    }
    
    var topVC: UIViewController?
    if result is UITabBarController {
        let tabBarVC = result as? UITabBarController
        let navVC = tabBarVC?.selectedViewController as? UINavigationController
        topVC = navVC?.topViewController
    } else if result is UINavigationController {
        let navVC = result as? UINavigationController
        topVC = navVC?.topViewController
    } else {
        topVC = result
    }
    
    let vc = topVC?.presentedViewController
    if let _ = vc {
        if vc is UINavigationController {
            let navVC = vc as? UINavigationController
            return navVC?.topViewController
        }
        return vc
    }
    
    return topVC
}
