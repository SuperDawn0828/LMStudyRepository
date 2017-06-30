//
//  LMPopupView.swift
//  LMPopupView
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

enum PopupAnimationType {
    
    case alert
    
    case sheet
    
    case custom
}

typealias PopupAnimation = (Void) -> ()

typealias InputHandler = (String?) -> ()

class LMPopupView: UIView {
    
    open var showAnimation: PopupAnimation?
    
    open var hideAnimation: PopupAnimation?
    
    open var showCompleted: PopupAnimation?
    
    open var hideCompleted: PopupAnimation?
    
    open var inputHandler: InputHandler?
    
    open var isWithKeyboard: Bool = false
    
    open var animationDuration: TimeInterval = 0.3
    
    open var animationType: PopupAnimationType = .alert {
        didSet {
            switch animationType {
            case .alert:
                showAnimation = alertShowAnimation
                hideAnimation = alertHideAnimation
            case .sheet:
                showAnimation = sheetShowAnimation
                hideAnimation = sheetHideAnimation
            case .custom:
                showAnimation = customShowAnimation
                hideAnimation = customHideAnimation
            }
        }
    }
    
    private var alertShowAnimation: PopupAnimation {
        let attachedView = LMAttachedView(frame: UIScreen.main.bounds)
        attachedView.addSubview(self)
        attachedView.showAttachedView()
        
        let animation: PopupAnimation = { [unowned self] in
            let size = self.frame.size
            let center = attachedView.center
            
            let centerX = center.x
            let centerY = self.isWithKeyboard ? (center.y - 216 / 2.0) : center.y
            
            self.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            self.center = CGPoint(x: centerX, y: centerY)
            
            self.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.2)
            self.alpha = 0.0
            
            UIView.animate(withDuration: self.animationDuration, delay: 0, options: .curveEaseInOut, animations: {
                self.layer.transform = CATransform3DIdentity
                self.alpha = 1.0
            }, completion: { (finish) in
                if let _ = self.showCompleted {
                    self.showCompleted!()
                }
            })
        }
        
        return animation
    }
    
    private var alertHideAnimation: PopupAnimation {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindowLevelNormal {
            for tmpWindow in UIApplication.shared.windows {
                if tmpWindow.windowLevel == UIWindowLevelNormal {
                    window = tmpWindow
                    break
                }
            }
        }
        
        var attachedView: LMAttachedView?
        for view in window!.subviews {
            if view is LMAttachedView {
                attachedView = view as? LMAttachedView
                break
            }
        }
        
        let animation: PopupAnimation = { [unowned self] in
            UIView.animate(withDuration: self.animationDuration, delay: 0, options: .curveEaseInOut, animations: {
                self.alpha = 0.0
            }, completion: { (finish) in
                if let _ = self.hideCompleted {
                    self.hideCompleted!()
                }
                self.removeFromSuperview()
            })
            attachedView?.hideAttachedView()
        }
        
        return animation
    }
    
    private var sheetShowAnimation: PopupAnimation {
        let attachedView = LMAttachedView(frame: UIScreen.main.bounds)
        attachedView.addSubview(self)
        attachedView.showAttachedView()
        
        let animation: PopupAnimation = { [unowned self] in
            let size = self.frame.size
            let attachedSize = attachedView.frame.size
            
            let popupY = attachedSize.height
            self.frame = CGRect(x: 0, y: popupY, width: size.width, height: size.height)
            
            UIView.animate(withDuration: self.animationDuration, delay: 0, options: .curveEaseOut, animations: {
                let showPopupY = attachedSize.height - size.height
                self.frame = CGRect(x: 0, y: showPopupY, width: size.width, height: size.height)
            }, completion: { (finish) in
                if let _ = self.showCompleted {
                    self.showCompleted!()
                }
            })
        }
        
        return animation
    }
    
    private var sheetHideAnimation: PopupAnimation {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindowLevelNormal {
            for tmpWindow in UIApplication.shared.windows {
                if tmpWindow.windowLevel == UIWindowLevelNormal {
                    window = tmpWindow
                    break
                }
            }
        }
        
        var attachedView: LMAttachedView?
        for view in window!.subviews {
            if view is LMAttachedView {
                attachedView = view as? LMAttachedView
                break
            }
        }
        
        let animation: PopupAnimation = { [unowned self] in
            let size = self.frame.size
            let attachedSize = attachedView?.frame.size
            
            UIView.animate(withDuration: self.animationDuration, delay: 0, options: .curveEaseOut, animations: {
                let popupY = attachedSize?.height
                self.frame = CGRect(x: 0, y: popupY!, width: size.width, height: size.height)
            }, completion: { (finish) in
                if let _ = self.hideCompleted {
                    self.hideCompleted!()
                }
                self.removeFromSuperview()
            })
            attachedView?.hideAttachedView()
        }
        
        return animation
    }
    
    private var customShowAnimation: PopupAnimation {
        let attachedView = LMAttachedView(frame: UIScreen.main.bounds)
        attachedView.addSubview(self)
        attachedView.showAttachedView()
        
        let animation: PopupAnimation = { [unowned self] in
            let size = self.frame.size
            let attachedSize = attachedView.frame.size
            let center = attachedView.center
            
            self.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            self.center = CGPoint(x: center.x, y: center.y + attachedSize.height)
            
            UIView.animate(withDuration: self.animationDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.5, options: .curveEaseOut, animations: { 
                let centerY = self.isWithKeyboard ? (center.y - 216 / 2.0) : center.y
                self.center = CGPoint(x: center.x, y: centerY)
            }, completion: { (finish) in
                if let _ = self.showCompleted {
                    self.showCompleted!()
                }
            })
        }
        
        return animation
    }
    
    private var customHideAnimation: PopupAnimation {
        let animation: PopupAnimation = { [unowned self] in
            
            var window = UIApplication.shared.keyWindow
            if window?.windowLevel != UIWindowLevelNormal {
                for tmpWindow in UIApplication.shared.windows {
                    if tmpWindow.windowLevel == UIWindowLevelNormal {
                        window = tmpWindow
                        break
                    }
                }
            }
            
            var attachedView: LMAttachedView?
            for view in window!.subviews {
                if view is LMAttachedView {
                    attachedView = view as? LMAttachedView
                    break
                }
            }
            
            let attachedSize = attachedView?.frame.size
            let center = self.center
            
            UIView.animate(withDuration: self.animationDuration, delay: 0, options: .curveEaseOut, animations: { 
                self.center = CGPoint(x: center.x, y: center.y + attachedSize!.height)
            }, completion: { (finish) in
                if let _ = self.hideCompleted {
                    self.hideCompleted!()
                }
                self.removeFromSuperview()
            })
            attachedView?.hideAttachedView()
        }
        
        return animation
    }
    
    open func show() {
        show(nil)
    }
    
    open func show(_ closure: PopupAnimation?) {
        if closure != nil {
            showCompleted = closure
        }
        
        showAnimation!()
        
        if isWithKeyboard {
            showKeyboard()
        }
    }
    
    open func hide() {
        hide(nil)
    }
    
    open func hide(_ closure: PopupAnimation?) {
        if closure != nil {
            hideCompleted = closure
        }
        
        if isWithKeyboard {
            hideKeyboard()
        }
        
        hideAnimation!()
    }
    
    open func showKeyboard() {
        
    }
    
    open func hideKeyboard() {
        
    }
}
