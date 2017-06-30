//
//  StringHelper.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/9.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

extension String {
    subscript (r: Range<Int>) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex =   self.index(self.startIndex, offsetBy: r.upperBound)
        return self[Range(startIndex ..< endIndex)]
    }
    
    subscript (i: Int) -> Character {
        let index = self.index(self.startIndex, offsetBy: i)
        return self[index]
    }
    
    func subString(to i: Int) -> String {
        let index = self.index(self.startIndex, offsetBy: i)
        return self.substring(to: index)
    }
    
    func subString(from i: Int) -> String {
        let index = self.index(self.startIndex, offsetBy: i)
        return self.substring(from: index)
    }
}

extension String {
    func stringIsEmpty() -> Bool {
        if self.isEmpty {
            return true
        } else {
            let string = self.trimmingCharacters(in: .whitespacesAndNewlines)
            if string.isEmpty {
                return true
            }
        }
        return false
    }
    
    func stringIsEmpty(shouldCleanWhiteSpace clean: Bool) -> Bool {
        if self.isEmpty {
            return true
        }
        
        if clean {
            let string = self.trimmingCharacters(in: .whitespacesAndNewlines)
            if string.isEmpty {
                return true
            }
        }
        
        return false
    }
    
    func stringIsEmpty(cleanCharacterSet characterSet: CharacterSet) -> Bool {
        if self.isEmpty {
            return true
        } else {
            let string = self.trimmingCharacters(in: characterSet)
            if string.isEmpty {
                return true
            }
        }
        return false
    }
}

extension String {
    func stringHeight(_ width: CGFloat, font: UIFont) -> CGFloat {
        
        let text = self as NSString
        let attri = [NSFontAttributeName: font]
        let rect = text.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: attri, context: nil)
        return rect.height
    }
    
    func stringWidth(_ height: CGFloat, font: UIFont) -> CGFloat {
        let text = self as NSString
        let attri = [NSFontAttributeName: font]
        let rect = text.boundingRect(with: CGSize.init(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: attri, context: nil)
        return rect.width
    }
}
