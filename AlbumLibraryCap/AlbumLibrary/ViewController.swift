//
//  ViewController.swift
//  AlbumLibrary
//
//  Created by 黎明 on 2017/8/24.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PhotoCapViewControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    //相机
    @IBAction func buttonAction(_ sender: UIButton) {
        AuthorizationCamera(photoCamera)
    }
    
    //相册
    @IBAction func buttonTwoAction(_ sender: UIButton) {
        AuthorizationAlbum(photoLibrary)
    }
    
    func photoCamera() {
        let pickImageVC = UIImagePickerController()
        pickImageVC.delegate = self
        pickImageVC.sourceType = .camera
        pickImageVC.allowsEditing = true
        present(pickImageVC, animated: true, completion: nil)
    }
    
    func photoLibrary() {
        let pickImageVC = UIImagePickerController()
        pickImageVC.delegate = self
        pickImageVC.sourceType = .photoLibrary
        present(pickImageVC, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        let photoClipVC = PhotoCapViewController()
        photoClipVC.delegate = self
        photoClipVC.image = image
        picker.pushViewController(photoClipVC, animated: true)
    }
    
    func photoCapViewControllerDidCancel(_ viewController: PhotoCapViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func photoCapViewController(_ viewController: PhotoCapViewController, didSelectedImage image: UIImage) {
        imageView.image = image
        viewController.dismiss(animated: true, completion: nil)
    }
    
    //相机权限
    func AuthorizationCamera(_ method: @escaping () -> ()) {
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        if status == .restricted || status == .denied {
            //无权限
        } else {
            method()
        }
    }
    
    //相册权限
    func AuthorizationAlbum(_ method: @escaping () -> ()) {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .restricted || status == .denied {
            
        } else {
            method()
        }
    }
}

