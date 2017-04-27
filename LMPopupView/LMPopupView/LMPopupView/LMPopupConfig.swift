//
//  LMPopupConfig.swift
//  LMPopupView
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

struct LMPopupConfig {
    
    var width: CGFloat = 275
    
    var splitWidth: CGFloat = 0.5
    
    var buttonHeight: CGFloat = 50
    
    var innerMargin: CGFloat = 20
    
    var cornerRadius: CGFloat = 5
    
    var titleFontSize: CGFloat = 18
    
    var detailFontSize: CGFloat = 14
    
    var buttonFontSize: CGFloat = 17
    
    var backgroundColor: UIColor = UIColorFromRGB(0xffffff)
    
    var titleColor: UIColor = UIColorFromRGB(0x222222)
    
    var detailColor: UIColor = UIColorFromRGB(0x222222)
    
    var splitColor: UIColor = UIColorFromRGB(0xcccccc)
    
    var actionNormalColor: UIColor = UIColorFromRGB(0x3bd2c9)
    
    var actionHighlightColor: UIColor = UIColorFromRGB(0x3bd2c9)
    
    var actionPressedColor: UIColor = UIColorFromRGB(0xefede7)
    
    var actionCancelColor: UIColor = UIColorFromRGB(0xa1a7ae)
    
    var defaultConfirm: String = "确定"
    
    var defaultCancel: String = "取消"
}

func UIColorFromRGB(_ value: Int) -> UIColor {
    let r: CGFloat = CGFloat((value & 0xff0000) >> 16) / 256.0
    let g: CGFloat = CGFloat((value & 0x00ff00) >> 08) / 256.0
    let b: CGFloat = CGFloat((value & 0x0000ff) >> 00) / 256.0
    
    let color = UIColor.init(red: r, green: g, blue: b, alpha: 1)
    
    return color
}

func StringOfSize(_ string: String, _ font: CGFloat, _ width: CGFloat) -> CGSize {
    let text: NSString = string as NSString
    let rect = text.boundingRect(with: CGSize(width:width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: font)], context: nil)
    return rect.size
}

func UIImageWithColor(_ color: UIColor) -> UIImage {
    let size = CGSize(width: 4.0, height: 4.0)
    let rect = CGRect(x: 0, y: 0, width: 4.0, height: 4.0)
    
    var image = UIImage()
    
    UIGraphicsBeginImageContext(size)
    if let context = UIGraphicsGetCurrentContext() {
        context.setFillColor(color.cgColor)
        context.fill(rect)
        
        let tmpImage = UIGraphicsGetImageFromCurrentImageContext()
        if tmpImage != nil {
            image = tmpImage!
        }
    }
    UIGraphicsEndImageContext()
    
    return image
}

//func TruncateStringByCharLength(_ toString: String, _ charLength: Int) -> String {
//    
//}





