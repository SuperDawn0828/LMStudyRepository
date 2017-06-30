//
//  LMImagePickerCollectionViewCell.swift
//  LMAlbumExample
//
//  Created by 黎明 on 2017/5/17.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import Photos

class LMImagePickerCollectionViewCell: UICollectionViewCell {
    
    private var imageView = UIImageView()
    
    private(set) var selectedButton = UIButton()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let photoSize = (UIScreen.main.bounds.width - 3.0) / 4.0
        imageView.frame = CGRect(x: 0, y: 0, width: photoSize, height: photoSize)
        imageView.layer.masksToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        contentView.addSubview(imageView)
        
        let buttonSize = photoSize / 4.0
        selectedButton.frame = CGRect(x: photoSize - buttonSize - 5.0, y: 5.0, width: buttonSize, height: buttonSize)
        selectedButton.setBackgroundImage(UIImage(named: "select_no"), for: .normal)
        selectedButton.setBackgroundImage(UIImage(named: "select_yes"), for: .selected)
        contentView.addSubview(selectedButton)
    }
    
    func imagePickerImage(_ asset: PHAsset) {
        GetImage(by: asset, complectionImage: CGSize(width: 200, height: 200)) { [unowned self] (image) in
            self.imageView.image = image
        }
    }
    
    func selectedStatus(_ selected: Bool) {
        selectedButton.isSelected = selected
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
