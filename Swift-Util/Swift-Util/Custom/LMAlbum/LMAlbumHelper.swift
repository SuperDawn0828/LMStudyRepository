//
//  LMAlbumDataHelper.swift
//  LMAlbumExample
//
//  Created by 黎明 on 2017/5/16.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import Photos

//获取全部相册
func GetPhotoListDatas() -> [PHAssetCollection] {
    var albums: [PHAssetCollection] = []
    
    let allSmartAlbumsFetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
    albums.append(allSmartAlbumsFetchResult.object(at: 0))
    
    let userSmartAlbumsGetchResult = PHAssetCollection.fetchTopLevelUserCollections(with: nil)
    userSmartAlbumsGetchResult.enumerateObjects({ (collecton, index, mutablePointer) in
        albums.append(collecton as! PHAssetCollection)
    })
    
    return albums
}

//获取一个相册的结果集
func GetFetchResult(_ assetCollecion: PHAssetCollection) -> PHFetchResult<PHAsset> {
    let fetchResult = PHAsset.fetchAssets(in: assetCollecion, options: nil)
    return fetchResult
}

//获取相机胶卷结果集
func GetCameraRollFetchResult() -> PHFetchResult<PHAsset> {
    let smartAlbumsFetchResult = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.smartAlbumUserLibrary, options: nil)
    let fetch = PHAsset.fetchAssets(in: smartAlbumsFetchResult.object(at: 0), options: nil)
    return fetch
}

//获取图片实体，放到数组中
func GetPhotoAssets(_ fetchResult: PHFetchResult<PHAsset>) -> [PHAsset] {
    var photoAssets: [PHAsset] = []
    fetchResult.enumerateObjects({ (asset, index, mutablePointer) in
        if asset.mediaType == PHAssetMediaType.image {
            photoAssets.append(asset)
        }
    })
    return photoAssets
}

//从asset中取出图片
func GetImage(by asset: PHAsset, complectionImage imageSize: CGSize?, complection: @escaping (UIImage?) -> ()) {
    
    var size: CGSize
    if imageSize == nil {
        size = CGSize(width: asset.pixelWidth, height: asset.pixelHeight)
    } else {
        size = imageSize!
    }
    
    let option = PHImageRequestOptions()
    option.resizeMode = .fast
    option.isSynchronous = false
    option.deliveryMode = .highQualityFormat
    
    PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: PHImageContentMode.aspectFit, options: option) { (result, info) in
        let isCancel = info?[PHImageCancelledKey] as? Bool
        let isError = info?[PHImageErrorKey] as? Bool
        
        guard let _ = isCancel, let _ = isError else {
            complection(result)
            return
        }
    }
}

//相册权限判断
func GetAlbumAuthorization(_ result: @escaping () -> ()){
    let status = PHPhotoLibrary.authorizationStatus()
    if status == PHAuthorizationStatus.denied {
        
    } else if status == PHAuthorizationStatus.notDetermined {
        PHPhotoLibrary.requestAuthorization({ (handler) in
            if handler == PHAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    result()
                }
            }
        })
    } else {
        
    }
}

