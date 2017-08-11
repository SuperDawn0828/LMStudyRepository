//
//  TranstationPresentationController.swift
//  ViewControllerTranstation
//
//  Created by 黎明 on 2017/8/11.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class TranstationPresentationController: UIPresentationController {
    
    let dimmingView = UIView()

    override func presentationTransitionWillBegin() {
        containerView?.addSubview(dimmingView)
        
        dimmingView.center = containerView!.center
        dimmingView.bounds = containerView!.bounds
        dimmingView.backgroundColor = .clear
        
        _ = presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [unowned self] _ in
            self.dimmingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        _ = presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [unowned self] _ in
            self.dimmingView.backgroundColor = .clear
        }, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        dimmingView.center = containerView!.center
        dimmingView.bounds = containerView!.bounds
        
        let width = containerView!.bounds.width
        let height = containerView!.bounds.height
        presentedView?.frame = CGRect(x: 0, y: height - 215, width: width, height: 215)
    }
}
