//
//  LMAlbumManager.swift
//  LMAlbumExample
//
//  Created by 黎明 on 2017/5/17.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import Photos

public typealias LMPhotoResult = ([UIImage]) -> ()

public class LMAsset: NSObject {
    
    var selected: Bool
    
    var asset: PHAsset
    
    init(_ selected: Bool, _ asset: PHAsset) {
        self.selected = selected
        self.asset = asset
    }
}

class LMAlbumManager: NSObject {
    
    private var maxSelectedNumber = 0
    
    private var callBack: LMPhotoResult?
        
    init(maxSelectedNumber: Int) {
        super.init()
        self.maxSelectedNumber = maxSelectedNumber
    }
    
    public func showAlbum(_ callBack: @escaping LMPhotoResult) {
        
        self.callBack = callBack
        
        GetAlbumAuthorization(pushAlbumViewController)
    }
    
    private func pushAlbumViewController() {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        if let _ = rootVC {
            let albumListVC = LMAlbumListViewController()
            albumListVC.callBack = callBack
            albumListVC.maxSelectedNumber = maxSelectedNumber
            
            let nav = UINavigationController(rootViewController: albumListVC)
            rootVC?.present(nav, animated: true, completion: nil)
            
            let imagePickerVC = LMImagePickerViewController()
            imagePickerVC.callBack = callBack
            imagePickerVC.fetchResult = GetCameraRollFetchResult()
            imagePickerVC.maxSelectedNumber = maxSelectedNumber
            albumListVC.navigationController?.pushViewController(imagePickerVC, animated: false)
            
        } else {
            
        }
    }
}
