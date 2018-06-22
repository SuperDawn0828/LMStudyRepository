//
//  ViewController.swift
//  Touch3D-Demo
//
//  Created by 黎明 on 2018/6/21.
//  Copyright © 2018年 黎明. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerPreviewingDelegate {
    
    var string: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let label = UILabel()
        label.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        label.center = view.center
        label.textAlignment = .center
        label.backgroundColor = .red
        label.text = string
        label.isUserInteractionEnabled = true
        label.tag = 10086
        view.addSubview(label)
        
        let label1 = UILabel()
        label1.frame = CGRect(x: 200, y: 400, width: 100, height: 100)
        label1.textAlignment = .center
        label1.backgroundColor = .red
        label1.text = string
        label1.isUserInteractionEnabled = true
        label1.tag = 10010
        view.addSubview(label1)
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: label1)
            registerForPreviewing(with: self, sourceView: label)
        }
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        if let label = previewingContext.sourceView as? UILabel, label.tag == 10086 {
            let vc = Touch3DViewController()
            vc.preferredContentSize = CGSize(width: 0, height: 300)
            return vc

        } else if let label = previewingContext.sourceView as? UILabel, label.tag == 10010 {
            let vc = OtherTouch3DViewController()
            vc.preferredContentSize = CGSize(width: 0, height: 300)
            return vc
        }
        
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        showDetailViewController(viewControllerToCommit, sender: self)
    }


}

