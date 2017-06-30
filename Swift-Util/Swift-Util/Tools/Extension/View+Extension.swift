//
//  ViewHelper.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/9.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

extension UIView {
    var left: CGFloat {
        set {
            self.frame.origin.x = newValue;
        }
        get {
            return self.frame.origin.x;
        }
    }
    
    var right: CGFloat {
        set {
            let delta = newValue - (self.frame.origin.x + self.frame.width)
            self.frame.origin.x += delta
        }
        get {
            return self.frame.origin.x + self.frame.width
        }
    }
    
    var top: CGFloat {
        set {
            self.frame.origin.y = newValue
        }
        get {
            return self.frame.origin.y
        }
    }
    
    var bottom: CGFloat {
        set {
            self.frame.origin.y = newValue - self.frame.height
        }
        get {
            return self.frame.origin.y + self.frame.height
        }
    }
    
    var centerX: CGFloat {
        set {
            self.center.x = newValue;
        }
        get {
            return self.center.x
        }
    }
    
    var centerY: CGFloat {
        set {
            self.center.y = newValue
        }
        get {
            return self.center.y
        }
    }
    
    var width: CGFloat {
        set {
            self.frame.size.width = newValue
        }
        get {
            return self.frame.width
        }
    }
    
    var height: CGFloat {
        set {
            self.frame.size.height = newValue
        }
        get {
            return self.frame.height
        }
    }
    
    var size: CGSize {
        set {
            self.frame.size = newValue
        }
        get {
            return self.frame.size
        }
    }
    
    var origin: CGPoint {
        set {
            self.frame.origin = newValue
        }
        get {
            return self.frame.origin
        }
    }
}

extension UIView {
    var viewController: UIViewController? {
        var view = self.superview
        while view != nil {
            let nextResponder = view?.next
            if nextResponder is UIViewController {
                return nextResponder as? UIViewController
            }
            view = view?.superview
        }
        return nil
    }
}

