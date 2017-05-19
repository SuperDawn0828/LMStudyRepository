//
//  LMImagePickerViewController.swift
//  LMAlbumExample
//
//  Created by 黎明 on 2017/5/17.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import Photos

class LMImagePickerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
        
    var maxSelectedNumber = 0
        
    var fetchResult: PHFetchResult<PHAsset>?
    
    var callBack: LMPhotoResult?
    
    private var collectionView: UICollectionView?
    
    private var dataArray: [LMAsset] = []
    
    private var selectedArray: [LMAsset] = []
    
    private let selectedNumberLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = fetchResult {
            let assets = getPhotoAssets(fetchResult!)
            for asset in assets {
                let lmAsset = LMAsset(false, asset)
                dataArray.append(lmAsset)
            }
        }
        
        setupNavigationBar()
        setupNavigationToolBar()
        setupSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
        navigationController?.toolbar.barStyle = .default
    }
    
    private func setupNavigationBar() {
        let rightItem = UIBarButtonItem(title: "关闭", style: .done, target: self, action: #selector(rightItemAction(_:)))
        navigationItem.rightBarButtonItem = rightItem
        
        let leftBackItem = UIBarButtonItem(title: "返回", style: .done, target: self, action: #selector(leftBackItemAction(_:)))
        navigationItem.leftBarButtonItem = leftBackItem
    }
    
    //MARK: - setupSubviews
    private func setupNavigationToolBar() {
        let toolLeftItem = UIBarButtonItem(title: "预览", style: .done, target: self, action: #selector(toolLeftItemAction(_:)))
        
        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        selectedNumberLabel.frame = CGRect(x: 0, y: 0, width: 23.25, height: 23.25)
        selectedNumberLabel.textColor = .white
        selectedNumberLabel.backgroundColor = UIColor(red: 248.0 / 255, green: 93.0 / 255, blue: 93.0 / 255, alpha: 1.0)
        selectedNumberLabel.text = String(format: "%d", selectedArray.count)
        selectedNumberLabel.textAlignment = .center
        selectedNumberLabel.font = UIFont.systemFont(ofSize: 14)
        selectedNumberLabel.layer.cornerRadius = 23.25 / 2.0
        selectedNumberLabel.layer.masksToBounds = true
        let selectedNumberItem = UIBarButtonItem(customView: selectedNumberLabel)
        
        let rightSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        let toolRightItem = UIBarButtonItem(title: "完成", style: .done, target: self, action: #selector(toolRightItemAction(_:)))
        toolbarItems = [toolLeftItem, spaceItem, selectedNumberItem, rightSpace, toolRightItem]
    }
    
    private func setupSubViews() {
        let photoSize: CGFloat = (UIScreen.main.bounds.width - 3.0) / 4.0
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 1.0
        flowLayout.minimumLineSpacing = 1.0
        flowLayout.itemSize = CGSize(width: photoSize, height: photoSize)
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        collectionView?.backgroundColor = .white
        collectionView?.isUserInteractionEnabled = true
        collectionView?.delegate = self
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
        
        collectionView?.register(LMImagePickerCollectionViewCell().classForCoder, forCellWithReuseIdentifier: "LMImagePickerCollectionViewCell")
    }
    
    //MARK: - delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let lmAsset = dataArray[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LMImagePickerCollectionViewCell", for: indexPath) as! LMImagePickerCollectionViewCell
        cell.imagePickerImage(lmAsset.asset)
        cell.selectedStatus(lmAsset.selected)
        
        cell.selectedButton.addTarget(self, action: #selector(collectionCellSelectedButtonAction(_:)), for: .touchUpInside)
        cell.selectedButton.tag = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let browerPickerVC = LMBrowsePickerViewController()
        browerPickerVC.indexPath = indexPath
        browerPickerVC.dataArray = dataArray
        browerPickerVC.selectedArray = selectedArray
        browerPickerVC.maxSelectedNumber = maxSelectedNumber
        browerPickerVC.callBack = { [unowned self] images in
            self.selectedArray = images
            self.selectedNumberText()
            self.collectionView?.reloadData()
        }
        navigationController?.pushViewController(browerPickerVC, animated: true)
    }
    
    //MARK: - Action
    @objc private func rightItemAction(_ item: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func leftBackItemAction(_ item: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func toolRightItemAction(_ item: UIBarButtonItem) {
        if selectedArray.count > 0 {
            var imageArray: [UIImage] = []
            for lmAsset in selectedArray {
                getImage(by: lmAsset.asset, complectionImage: nil, complection: { (image) in
                    if let _ = image {
                        imageArray.append(image!)
                    }
                })
            }
            
            callBack?(imageArray)
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func toolLeftItemAction(_ item: UIBarButtonItem) {
        
        if selectedArray.count <= 0 {
            return
        }
        
        let browerPickerVC = LMBrowsePickerViewController()
        browerPickerVC.dataArray = selectedArray
        browerPickerVC.selectedArray = selectedArray
        browerPickerVC.maxSelectedNumber = maxSelectedNumber
        browerPickerVC.callBack = { [unowned self] images in
            self.selectedArray = images
            self.selectedNumberText()
            self.collectionView?.reloadData()
        }
        navigationController?.pushViewController(browerPickerVC, animated: true)
    }
    
    @objc private func collectionCellSelectedButtonAction(_ sender: UIButton) {
        
        let lmAsset = dataArray[sender.tag]
        
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
        selectedNumberText()
    }
    
    //MARK: - Other
    private func selectedPhotoArray(_ lmAsset: LMAsset) {
        if lmAsset.selected {
            selectedArray.append(lmAsset)
        } else {
            let index = selectedArray.index(of: lmAsset)
            selectedArray.remove(at: index!)
        }
    }
    
    private func selectedNumberText() {
        selectedNumberLabel.text = String(format: "%d", selectedArray.count)
        albumAnimation(view: selectedNumberLabel)
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
