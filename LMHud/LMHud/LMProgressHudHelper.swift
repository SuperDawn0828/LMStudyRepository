//
//  LMProgressHudHelper.swift
//  LMHud
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

func showWaitingHud() {
    let spinnerWidth: CGFloat = 18
    let spinner = LMCircleSpinner(frame: CGRect(x: 0, y: 0, width: spinnerWidth, height: spinnerWidth))
    let waitingHud = LMHud(title: "加载中...", customView: spinner)
    
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
    
    let coverView = UIView(frame: window!.bounds)
    coverView.tag = 20170421
    waitingHud.showInView(view: coverView)
    
    window?.addSubview(coverView)
}

func dismissWaitingHud() {
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
    
    for view in window!.subviews {
        let tag = view.tag
        if tag == 20170421 {
            view.removeFromSuperview()
            return
        }
    }
}

func showQuickTips(title: String) {
    DispatchQueue.main.async {
        let hud = LMHud(title: title)
        hud.tag = 20170422
        
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
        hud.showInView(view: window)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: { 
            hud.dismiss()
        })
    }
}

func showQuickTips(title: String, inView: UIView) {
    DispatchQueue.main.async {
        let hud = LMHud(title: title)
        hud.showInView(view: inView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: { 
            hud.dismiss()
        })
    }
    
}
