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
func getPhotoListDatas() -> [PHAssetCollection] {
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
func getFetchResult(_ assetCollecion: PHAssetCollection) -> PHFetchResult<PHAsset> {
    let fetchResult = PHAsset.fetchAssets(in: assetCollecion, options: nil)
    return fetchResult
}

//获取相机胶卷结果集
func getCameraRollFetchResult() -> PHFetchResult<PHAsset> {
    let smartAlbumsFetchResult = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.smartAlbumUserLibrary, options: nil)
    let fetch = PHAsset.fetchAssets(in: smartAlbumsFetchResult.object(at: 0), options: nil)
    return fetch
}

//获取图片实体，放到数组中
func getPhotoAssets(_ fetchResult: PHFetchResult<PHAsset>) -> [PHAsset] {
    var photoAssets: [PHAsset] = []
    fetchResult.enumerateObjects({ (asset, index, mutablePointer) in
        if asset.mediaType == PHAssetMediaType.image {
            photoAssets.append(asset)
        }
    })
    return photoAssets
}

//从asset中取出图片
func getImage(by asset: PHAsset, complectionImage imageSize: CGSize?, complection: @escaping (UIImage?) -> ()) {
    let photoWidth = UIScreen.main.bounds.width
    let aspectRatio = photoWidth / CGFloat(asset.pixelWidth)
    
    var size = CGSize(width: 0, height: 0)
    if let _ = imageSize {
        size = CGSize(width: imageSize!.width, height: imageSize!.height)
    } else {
        let pixelWidth = photoWidth
        let pixelHeight = CGFloat(asset.pixelHeight) * aspectRatio
        size = CGSize(width: pixelWidth, height: pixelHeight)
    }
    
    PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: PHImageContentMode.aspectFit, options: nil) { (result, info) in
        let isCancel = info?[PHImageCancelledKey] as? Bool
        let isError = info?[PHImageErrorKey] as? Bool
        
        guard let _ = isCancel, let _ = isError else {
            complection(result)
            return
        }
    }
}

//相册权限判断
func getAlbumAuthorization(_ result: @escaping () -> ()){
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
    } else if status == PHAuthorizationStatus.authorized {
        result()
    } else {
        
    }
}

