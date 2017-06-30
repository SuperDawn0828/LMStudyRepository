//
//  Button+Extension.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/21.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

private let topEdgeKey      = UnsafeRawPointer(bitPattern: "topEdgeKey".hashValue)

private let leftEdgeKey     = UnsafeRawPointer(bitPattern: "leftEdgeKey".hashValue)

private let rightEdgeKey    = UnsafeRawPointer(bitPattern: "rightEdgeKey".hashValue)

private let bottomEdgeKey   = UnsafeRawPointer(bitPattern: "bottomEdgeKey".hashValue)


extension UIButton {
    
    private var enlargeRect: CGRect {
        
        let topEdge = objc_getAssociatedObject(self, topEdgeKey) as? CGFloat
        let leftEdge = objc_getAssociatedObject(self, leftEdgeKey) as? CGFloat
        let rightEdge = objc_getAssociatedObject(self, rightEdgeKey) as? CGFloat
        let bottomEdge = objc_getAssociatedObject(self, bottomEdgeKey) as? CGFloat
        
        if topEdge != nil && leftEdge != nil && rightEdge != nil && bottomEdge != nil {
            return CGRect(x: bounds.origin.x - leftEdge!,
                          y: bounds.origin.y - topEdge!,
                          width: bounds.size.width + leftEdge! + rightEdge!,
                          height: bounds.size.height + topEdge! + bottomEdge!)
        } else {
            return bounds
        }
    }
    
    func setEnlargeEdge(size: CGFloat) {
        objc_setAssociatedObject(self, topEdgeKey, size, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, leftEdgeKey, size, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, rightEdgeKey, size, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, bottomEdgeKey, size, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func setEnlargeEdge(edge: UIEdgeInsets) {
        objc_setAssociatedObject(self, topEdgeKey, edge.top, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, leftEdgeKey, edge.left, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, rightEdgeKey, edge.right, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, bottomEdgeKey, edge.bottom, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = enlargeRect
        if rect.equalTo(bounds) {
            return super.point(inside: point, with: event)
        } else {
            return rect.contains(point)
        }
    }
}
