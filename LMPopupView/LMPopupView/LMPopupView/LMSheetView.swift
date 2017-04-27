//
//  LMSheetView.swift
//  LMPopupView
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class LMSheetView: LMPopupView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        animationType = .sheet
        
        animationDuration = 0.3
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
