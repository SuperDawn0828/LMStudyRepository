//
//  ColorHelper.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/8.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

func UIColorFromRGB(_ rgb: Int) -> UIColor {
    let r = Float((rgb & 0xff0000) >> 16) / 255.0
    let g = Float((rgb & 0x00ff00) >> 08) / 255.0
    let b = Float((rgb & 0x0000ff) >> 00) / 255.0
    
    let color = UIColor(colorLiteralRed: r, green: g, blue: b, alpha: 1)
    return color
}

func UIColorFromRGB(_ rgb: Int, alpha: Float) -> UIColor {
    let r = Float((rgb & 0xff0000) >> 16) / 255.0
    let g = Float((rgb & 0x00ff00) >> 08) / 255.0
    let b = Float((rgb & 0x000000) >> 00) / 255.0
    
    let color = UIColor(colorLiteralRed: r, green: g, blue: b, alpha: alpha)
    return color
}

extension UIColor {
    class var disable: UIColor {
        return UIColorFromRGB(0x333333)
    }
}
