//
//  LMAttachedView.swift
//  LMPopupView
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class LMAttachedView: UIView {
    
    var touchWildToHide: Bool = true
    
    open func showAttachedView() {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindowLevelNormal {
            for tmpWindow in UIApplication.shared.windows {
                if tmpWindow.windowLevel == UIWindowLevelNormal {
                    window = tmpWindow
                    break
                }
            }
        }
        
        window?.addSubview(self)
        backgroundColor = .clear
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { 
            self.backgroundColor = UIColor(white: 0, alpha: 0.6)
        }) { (finish) in
            
        }
    }
    
    open func hideAttachedView() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.backgroundColor = .clear
        }) { (finish) in
            self.removeFromSuperview()
        }
    }
    
    open func hideAllSubViews() {
        for view in subviews {
            if view is LMPopupView {
                let v = view as! LMPopupView
                v.hide()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = (touches as NSSet).anyObject() as! UITouch
        let touchView = touch.view
        
        if touchView is LMAttachedView && touchWildToHide{
            for view in subviews {
                if view is LMPopupView {
                    let v = view as! LMPopupView
                    v.hide()
                }
            }
        }
    }
}
