//
//  BrowerPickerCollectionViewCell.swift
//  LMAlbumExample
//
//  Created by 黎明 on 2017/5/17.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import Photos

class BrowerPickerCollectionViewCell: UICollectionViewCell {
    
    private var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let viewWidth = UIScreen.main.bounds.width
        let viewHeight = UIScreen.main.bounds.height
        
        imageView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
    }
    
    func photoBrowerData(by asset: PHAsset) {
        GetImage(by: asset, complectionImage: nil) { [unowned self] (image) in
            self.imageView.image = image
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
