//
//  ShareCollectionViewCell.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/13.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class ShareCollectionViewCell: UICollectionViewCell {
    
    private(set) var itemImageView = UIImageView()
    
    private(set) var itemTitlelabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.frame = CGRect(x: 0, y: 0, width: 53, height: 53)
        contentView.addSubview(itemImageView)
        
        itemTitlelabel.textColor = .black
        itemTitlelabel.font = UIFont.systemFont(ofSize: 12)
        itemTitlelabel.frame = CGRect.init(x: 0, y: 68, width: 53, height: 13)
        itemTitlelabel.textAlignment = .center
        contentView.addSubview(itemTitlelabel)
    }
    
}
