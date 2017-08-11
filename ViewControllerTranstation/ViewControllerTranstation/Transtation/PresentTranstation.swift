//
//  PresentTranstation.swift
//  ViewControllerTranstation
//
//  Created by 黎明 on 2017/8/11.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class PresentTranstation: NSObject, UIViewControllerAnimatedTransitioning {
    
    var transtationStyle: PresentTranstationStyle
    
    enum PresentTranstationStyle {
                
        case present
        
        case dismiss
    }
    
    init(_ transtationStyle: PresentTranstationStyle) {
        self.transtationStyle = transtationStyle
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if transtationStyle == .present {
            presentAnimationTransition(using: transitionContext)
        } else {
            dismissAnimationTransition(using: transitionContext)
        }
    }
    
    func presentAnimationTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        let toView = toVC.view
        let width = containerView.bounds.width
        let height = containerView.bounds.height
        
        containerView.addSubview(toView!)
        toView?.frame = CGRect(x: 0, y: height, width: width, height: 215)
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: {
                            toView?.frame = CGRect(x: 0, y: height - 215, width: width, height: 215)
                       },
                       completion: { (finish) in
                            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                       })
    }
    
    func dismissAnimationTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: .from) else {
            return
        }
        
        let fromView = fromVC.view
        let width = containerView.bounds.width
        let height = containerView.bounds.height
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: {
                            fromView?.frame = CGRect(x: 0, y: height, width: width, height: 215)
                       },
                       completion: { (finish) in
                            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                       })
    }
}
