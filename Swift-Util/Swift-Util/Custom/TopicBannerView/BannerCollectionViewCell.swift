//
//  BannerCollectionViewCell.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/14.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    private(set) var bannerImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bannerImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        bannerImageView.contentMode = .scaleAspectFill
        contentView.addSubview(bannerImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
