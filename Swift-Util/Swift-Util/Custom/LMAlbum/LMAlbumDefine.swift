//
//  LMAlbumDefine.swift
//  LMAlbumExample
//
//  Created by 黎明 on 2017/5/18.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

func AlbumAnimation<T: UIView>(view: T) {
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

func AlbumSelectedShowAlert(_ number: Int) {
    let alertView = UIAlertController(title: nil, message: "最多可选择\(number)张图片", preferredStyle: .alert)
    let certainAction = UIAlertAction(title: "确定", style: .default, handler: nil)
    alertView.addAction(certainAction)
    
    let currentVC = GetCurrentViewController()
    currentVC?.present(alertView, animated: true, completion: nil)
}
