//
//  LMPopupAction.swift
//  LMPopupView
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

enum LMPopupActionType {
    
    case disable
    
    case normal
    
    case highlight
}

struct LMPopupAction {
    
    var actionType: LMPopupActionType
    
    var title: String
    
    var action: (Int) -> ()
    
    init(_ title: String, _ actionType: LMPopupActionType, _ action: @escaping (Int) -> ()) {
        self.title = title
        
        self.actionType = actionType
        
        self.action = action
    }
}
