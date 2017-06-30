//
//  ViewControllerHelper.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/11.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

extension UIViewController {
    //设置导航栏
    func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        let whiteImage = UIImage.image(by: .white)
        navigationController?.navigationBar.setBackgroundImage(whiteImage, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.barStyle = .default
        
        let font: UIFont = .title
        let titleColor: UIColor = .disable
        let attti = [NSFontAttributeName: font,
                     NSForegroundColorAttributeName: titleColor]
        navigationController?.navigationBar.titleTextAttributes = attti
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //设置导航栏为透明
    func setupNavigationBarTranslucent() {
        let clearImage = UIImage.image(by: .clear)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.setBackgroundImage(clearImage, for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    //设置导航栏返回按钮
    func setupBackNavigationButton() {
        if (navigationController != nil && navigationController?.viewControllers.first != self) || navigationController?.presentingViewController != nil {
            let backImage = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
            let leftItem = UIBarButtonItem(image: backImage,
                                           style: .done,
                                           target: self,
                                           action: #selector(clickedNavLeftItem))
            navigationItem.leftBarButtonItem = leftItem
        }
    }
    
    //根据字符串设置导航栏返回按钮
    func setupBackNavigationButton(with title: String) {
        let button = UIButton()
        button.isExclusiveTouch = true
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = FontWithSize(16)
        button.addTarget(self, action: #selector(clickedNavLeftItem), for: .touchUpInside)
        button.sizeToFit()
        
        let backItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = backItem
    }
    
    //设置导航栏右侧按钮
    func setupRightNavigationButton(with title: String) {
        
    }
    
    //根据字符串得到barButtonItem
    func barBttonItem(with title: String, color: UIColor, target: Any, action: Selector, for controlEvents: UIControlEvents) -> UIBarButtonItem {
        let button = UIButton()
        button.titleLabel?.font = FontWithSize(16)
        button.setTitleColor(color, for: .normal)
        button.setTitleColor(color.withAlphaComponent(0.5), for: .highlighted)
        button.setTitleColor(.gray, for: .disabled)
        button.addTarget(target, action: action, for: controlEvents)
        button.sizeToFit()
        
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
    
    //隐藏导航栏底部线
    func hideShadowInNavigationBar() {
        let whiteImage = UIImage.image(by: .white)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.setBackgroundImage(whiteImage, for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc private func clickedNavLeftItem() {
        self.navigationController?.popViewController(animated: true)
    }
}


