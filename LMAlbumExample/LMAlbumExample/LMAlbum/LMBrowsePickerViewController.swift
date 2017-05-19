//
//  LMBrowsePickerViewController.swift
//  LMAlbumExample
//
//  Created by 黎明 on 2017/5/17.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import Photos

class LMBrowsePickerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    private var collectionView: UICollectionView? = nil
    
    private var selectedButton = UIButton()
    
    var maxSelectedNumber = 0
    
    var dataArray: [LMAsset] = []
    
    var selectedArray: [LMAsset] = []
    
    var indexPath = IndexPath(row: 0, section: 0)
    
    var callBack: (([LMAsset]) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        setupSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    private func setupSubViews() {
        
        let viewWidth = UIScreen.main.bounds.width
        let viewHeight = UIScreen.main.bounds.height
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: viewWidth, height: viewHeight)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        collectionView?.backgroundColor = .clear
        collectionView?.isPagingEnabled = true
        collectionView?.isScrollEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
        
        collectionView?.register(BrowerPickerCollectionViewCell().classForCoder, forCellWithReuseIdentifier: "BrowerPickerCollectionViewCell")
        collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(rawValue: 0), animated: false)
    }
    
    private func setupNavigationBar() {
        selectedButton.frame = CGRect(x: 0, y: 0, width: 23.25, height: 23.25)
        selectedButton.setBackgroundImage(UIImage(named: "select_no"), for: .normal)
        selectedButton.setBackgroundImage(UIImage(named: "select_yes"), for: .selected)
        selectedButton.addTarget(self, action: #selector(selectedButtonAction(_:)), for: .touchUpInside)
        
        let rightItem = UIBarButtonItem(customView: selectedButton)
        navigationItem.rightBarButtonItem = rightItem
        
        let leftBackItem = UIBarButtonItem(title: "返回", style: .done, target: self, action: #selector(leftBackItemAction(_:)))
        navigationItem.leftBarButtonItem = leftBackItem
        
        selectedButtonIsSelected(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let lmAsset = dataArray[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrowerPickerCollectionViewCell", for: indexPath) as! BrowerPickerCollectionViewCell
        cell.photoBrowerData(by: lmAsset.asset)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset
        let index = Int(contentOffset.x / 375.0)
        indexPath.row = index
        
        selectedButtonIsSelected(indexPath)
    }
    
    func selectedButtonIsSelected(_ indexPath: IndexPath) {
        let lmAsset = dataArray[indexPath.row]
        selectedButton.isSelected = lmAsset.selected
    }
    
    
    @objc private func selectedButtonAction(_ sender: UIButton) {
        let index = indexPath.row
        let lmAsset = dataArray[index]
        
        let isAlreadySelected = lmAsset.selected
        let isAllowSelected = isAllowSelectedPhoto()
        
        if !isAllowSelected && !isAlreadySelected{
            albumSelectedShowAlert(maxSelectedNumber)
            return
        }
        
        sender.isSelected = !sender.isSelected
        albumAnimation(view: sender)
        
        lmAsset.selected = sender.isSelected
        
        selectedPhotoArray(lmAsset)
    }
    
    @objc private func leftBackItemAction(_ item: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        callBack?(selectedArray)
    }
    
    private func selectedPhotoArray(_ lmAsset: LMAsset) {
        if lmAsset.selected {
            selectedArray.append(lmAsset)
        } else {
            let index = selectedArray.index(of: lmAsset)
            selectedArray.remove(at: index!)
        }
    }
    
    private func isAllowSelectedPhoto() -> Bool{
        if selectedArray.count >= maxSelectedNumber {
            return false
        } else {
            return true
        }
    }
    
    func albumSelectedShowAlert(_ number: Int) {
        let alertView = UIAlertController(title: nil, message: "最多可选择\(number)张图片", preferredStyle: .alert)
        let certainAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        alertView.addAction(certainAction)
        present(alertView, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
