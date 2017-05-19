//
//  LMAlbumListTableViewCell.swift
//  LMAlbumExample
//
//  Created by 黎明 on 2017/5/17.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import Photos

class LMAlbumListTableViewCell: UITableViewCell {
    
    private let coverImageView = UIImageView()
    
    private let titleLabel = UILabel()
    
    private let subTitleLabel = UILabel()
    
    private let lineView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        let innerMargin: CGFloat = 5
        let viewWidth = UIScreen.main.bounds.width
        
        let imageWidth: CGFloat = 60
        let imageHeight: CGFloat = 60
        
        coverImageView.frame = CGRect(x: 2 * innerMargin, y: innerMargin, width: imageWidth, height: imageHeight)
        coverImageView.layer.masksToBounds = true
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.image = UIImage(named: "no_data")
        contentView.addSubview(coverImageView)
        
        let subTitleWidth: CGFloat = 60.0
        let subTitleX: CGFloat = viewWidth - innerMargin - subTitleWidth
        let titleWidth = viewWidth - 4.0 * innerMargin - subTitleWidth
        let titleX = 3 * innerMargin + imageWidth
        let labelHeight: CGFloat = 60.0
        
        titleLabel.frame = CGRect(x: titleX, y: innerMargin, width: titleWidth, height: labelHeight)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        contentView.addSubview(titleLabel)
        
        subTitleLabel.frame = CGRect(x: subTitleX, y: innerMargin, width: subTitleWidth, height: labelHeight)
        subTitleLabel.textColor = UIColor(red: CGFloat(199.0 / 256.0), green: CGFloat(199.0 / 256.0), blue: CGFloat(199.0 / 256.0), alpha: 1.0)
        subTitleLabel.textAlignment = .right
        contentView.addSubview(subTitleLabel)
        
        let lineHeight: CGFloat = 1
        let lineY: CGFloat = 70 - lineHeight
        
        lineView.frame = CGRect.init(x: 0, y: lineY, width: viewWidth, height: lineHeight)
        lineView.backgroundColor = UIColor(red: CGFloat(199.0 / 256.0), green: CGFloat(199.0 / 256.0), blue: CGFloat(199.0 / 256.0), alpha: 1.0)
        contentView.addSubview(lineView)
    }
    
    func albumListData(_ assetCollection: PHAssetCollection) {
        let fetchResult = getFetchResult(assetCollection)
        let assetArray = getPhotoAssets(fetchResult)
        
        if let _ = assetArray.last {
            getImage(by: assetArray.last!, complectionImage: CGSize(width: 200.0, height: 200.0)) { [unowned self] (image) in
                if let _ = image {
                    self.coverImageView.image = image
                } else {
                    self.coverImageView.image = UIImage(named: "no_data")
                }
            }
        }
        
        if assetCollection.localizedTitle == "Camera Roll" {
            titleLabel.text = "相机胶卷"
        } else {
            titleLabel.text = assetCollection.localizedTitle
        }
        
        subTitleLabel.text = String.init(format: "(%d)", assetArray.count)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
