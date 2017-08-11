//
//  TranstationDelegate.swift
//  ViewControllerTranstation
//
//  Created by 黎明 on 2017/8/11.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class TranstationDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transitation = PresentTranstation(.present)
        return transitation
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transitation = PresentTranstation(.dismiss)
        return transitation
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return TranstationPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
}
