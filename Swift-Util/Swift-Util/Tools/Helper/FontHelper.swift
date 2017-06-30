//
//  FontHelper.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/9.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import Foundation

func FontWithSize(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

func BoldFontWithSize(_ size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size)
}

extension UIFont {
    
    class var title: UIFont {
        return FontWithSize(16)
    }
    
    class var boldTitle: UIFont {
        return BoldFontWithSize(16)
    }
    
}
