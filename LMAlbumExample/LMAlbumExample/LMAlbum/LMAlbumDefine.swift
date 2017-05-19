//
//  LMAlbumDefine.swift
//  LMAlbumExample
//
//  Created by 黎明 on 2017/5/18.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

func albumAnimation<T: UIView>(view: T) {
    let animation = CAKeyframeAnimation(keyPath: "transform")
    animation.duration = 0.5
    var values: [CATransform3D] = []
    values.append(CATransform3DMakeScale(0.1, 0.1, 1.0))
    values.append(CATransform3DMakeScale(1.2, 1.2, 1.0))
    values.append(CATransform3DMakeScale(0.9, 0.9, 1.0))
    values.append(CATransform3DMakeScale(1.0, 1.0, 1.0))
    animation.values = values
    view.layer.add(animation, forKey: nil)
}
