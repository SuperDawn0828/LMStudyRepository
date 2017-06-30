//
//  ShareView.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/13.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class ShareView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let contentView = UIView()
    
    var shareItems: [ShareItem] = []
    
    var shareAction: ((Int) -> ())? = nil
    
    convenience init(_ shareItems: [ShareItem], shareAction: @escaping (Int) -> ()) {
        self.init(frame: .zero)
        
        backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        self.shareItems = shareItems
        
        self.shareAction = shareAction
        
        setupSubviews()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    fileprivate func setupSubviews() {
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let contentViewHeight: CGFloat = 175
        let outerMargin: CGFloat = 25
        
        contentView.backgroundColor = .white
        contentView.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: contentViewHeight)
        addSubview(contentView)
        
        let titleLabelWidth = screenWidth - 2 * outerMargin
        let titleLabelHeight: CGFloat = 14
        
        let titleLabel = UILabel()
        titleLabel.text = "请选择分享方式"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.frame = CGRect.init(x: outerMargin, y: outerMargin, width: titleLabelWidth, height: titleLabelHeight)
        contentView.addSubview(titleLabel)
        
        let itemWidth: CGFloat = 53
        let itemHeight: CGFloat = 81
        let innerMargin: CGFloat = (screenWidth - 4 * itemWidth - outerMargin * 2) / 3.0
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = innerMargin
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: outerMargin, bottom: 0, right: outerMargin)
        
        let collectionViewY = outerMargin + titleLabelHeight + 30
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: collectionViewY, width: screenWidth, height: itemHeight), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        contentView.addSubview(collectionView)
        
        collectionView.register(ShareCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "ShareCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shareItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let shareItem = shareItems[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShareCollectionViewCell", for: indexPath) as! ShareCollectionViewCell
        cell.itemTitlelabel.text = shareItem.itemTitle;
        cell.itemImageView.image = UIImage(named: shareItem.itemImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if shareAction != nil {
            shareAction!(indexPath.row)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hide()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindowLevelNormal {
            for tmpWindow in UIApplication.shared.windows {
                if tmpWindow.windowLevel == UIWindowLevelNormal {
                    window = tmpWindow
                    break
                }
            }
        }
        window?.addSubview(self)
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let contentViewHeight: CGFloat = 175
        
        alpha = 0.0
        frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { [unowned self] in
            self.alpha = 1
            self.contentView.frame = CGRect(x: 0, y: screenHeight - contentViewHeight, width: screenWidth, height: contentViewHeight)
        }, completion: nil)
        
    }
    
    func hide() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let contentViewHeight: CGFloat = 175
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { [unowned self] in
            self.alpha = 0
            self.contentView.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: contentViewHeight)
        }) { [unowned self] (finish) in
            self.removeFromSuperview()
        }
    }
}
