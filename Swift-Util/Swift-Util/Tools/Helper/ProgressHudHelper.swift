//
//  ProgressHUDHelper.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/14.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import MBProgressHUD
func ShowProgressHud() {
    let hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
    hud.contentColor = .white
    hud.bezelView.backgroundColor = .black
}

func DismissProgressHud() {
    MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
    
}

func ShowProgressHud(in view: UIView) {
    let hud = MBProgressHUD.showAdded(to: view, animated: true)
    hud.contentColor = .white
    hud.bezelView.backgroundColor = .black
}

func DismissProgressHud(in view: UIView) {
    MBProgressHUD.hide(for: view, animated: true)
}

func ShowProgressHud(toast message: String) {
    let hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
    hud.contentColor = .white
    hud.bezelView.backgroundColor = .black
    hud.mode = .text
    hud.label.text = message
    hud.margin = 10
    hud.removeFromSuperViewOnHide = true
    hud.hide(animated: true, afterDelay: 2)
}

func ShowProgressHud(toast message: String, in view: UIView) {
    let hud = MBProgressHUD.showAdded(to: view, animated: true)
    hud.contentColor = .white
    hud.bezelView.backgroundColor = .black
    hud.mode = .text
    hud.label.text = message
    hud.margin = 10
    hud.removeFromSuperViewOnHide = true
    hud.hide(animated: true, afterDelay: 2)
}

func ShowWaitingHud() {
    let spinnerWidth: CGFloat = 18
    let spinner = LMCircleSpinner(frame: CGRect(x: 0, y: 0, width: spinnerWidth, height: spinnerWidth))
    let waitingHud = LMHud(title: "加载中...", customView: spinner)
    
    let window = UIApplication.shared.keyWindow
    let coverView = UIView(frame: window!.bounds)
    coverView.tag = 20170421
    window?.addSubview(coverView)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { 
        waitingHud.showInView(view: coverView)
    }
}

func ShowQuicklyWaitingHud() {
    let spinnerWidth: CGFloat = 18
    let spinner = LMCircleSpinner(frame: CGRect(x: 0, y: 0, width: spinnerWidth, height: spinnerWidth))
    let waitingHud = LMHud(title: "加载中...", customView: spinner)
    
    let window = UIApplication.shared.keyWindow
    let coverView = UIView(frame: window!.bounds)
    coverView.tag = 20170421
    window?.addSubview(coverView)
    
    waitingHud.showInView(view: coverView)
}

func ShowWaitingHud(_ title: String, in view: UIView) {
    let spinnerWidth: CGFloat = 18
    let spinner = LMCircleSpinner(frame: CGRect(x: 0, y: 0, width: spinnerWidth, height: spinnerWidth))
    let waitingHud = LMHud(title: title, customView: spinner)
    waitingHud.showInView(view: view)
}

func DismissWaitingHud() {
    let window = UIApplication.shared.keyWindow
    for view in window!.subviews {
        let tag = view.tag
        if tag == 20170421 {
            view.removeFromSuperview()
            break
        }
    }
}

func DismissWaitingHud(in view: UIView) {
    for subView in view.subviews {
        if subView is LMHud {
            let hud = subView as? LMHud
            hud?.dismiss()
            break
        }
    }
}

func ShowQuicklyTips(_ title: String) {
    DispatchQueue.main.async {
        let hud = LMHud(title: title)
        hud.tag = 20170422
        
        let window = UIApplication.shared.keyWindow
        hud.showInView(view: window)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            hud.dismiss()
        })
    }
}

func ShowQuicklyTips(_ title: String, in view: UIView) {
    DispatchQueue.main.async {
        let hud = LMHud(title: title)
        hud.showInView(view: view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            hud.dismiss()
        })
    }
}

