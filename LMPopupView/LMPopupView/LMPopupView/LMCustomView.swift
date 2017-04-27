//
//  LMCustomView.swift
//  LMPopupView
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class LMCustomView: LMPopupView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        animationType = .custom
        animationDuration = 0.3
        isWithKeyboard = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
