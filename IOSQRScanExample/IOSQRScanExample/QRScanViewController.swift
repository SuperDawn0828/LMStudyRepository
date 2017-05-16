//
//  QRScanViewController.swift
//  IOSQRScanExample
//
//  Created by 黎明 on 2017/5/15.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class QRScanViewController: UIViewController, QRScanManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var qrScanManager: QRScanManager?
    
    private var qrScanView: QRScanView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = UIRectEdge.bottom
        
        setupNavigationBarItem()
        setupSubViews()
        setupScanManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        qrScanView?.startLineAnimation()
        qrScanManager?.startQRScanning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        qrScanManager?.stopQRScanning()
    }
    
    // MARK: - SetupSubviews
    private func setupNavigationBarItem() {
        let leftBarItem = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(leftBarItemAction(_:)))
        navigationItem.leftBarButtonItem = leftBarItem
        
        let rightBarItem = UIBarButtonItem.init(barButtonSystemItem: .camera, target: self, action: #selector(rightBarItemAction(_:)))
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    private func setupSubViews() {
        let viewWidth = UIScreen.main.bounds.width
        let viewHeight = UIScreen.main.bounds.height - 64
        
        qrScanView = QRScanView(frame: CGRect.init(x: 0, y: 0, width: viewWidth, height: viewHeight))
        view.addSubview(qrScanView!)
    }
    
    private func setupScanManager() {
        qrScanManager = QRScanManager(view.layer)
        qrScanManager?.delegate = self
    }
    
    // MARK: - Action
    @objc private func leftBarItemAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func rightBarItemAction(_ sender: UIBarButtonItem) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            return
        }
        
        let photoLibrary = UIImagePickerController()
        photoLibrary.delegate = self
        photoLibrary.sourceType = .photoLibrary
        present(photoLibrary, animated: true, completion: nil)
    }
    
    // MARK: - Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let ciImage = CIImage(image: image)
        let detector = CIDetector.init(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        let features = detector?.features(in: ciImage!)
        
        if let feature = features?.first as? CIQRCodeFeature {
            let message = feature.messageString
            gotoQRHandle(message)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func qrScanManager(_ manager: QRScanManager, completedScanningWithOutput output: String?) {
        DispatchQueue.main.async {
            self.gotoQRHandle(output)
        }
    }
    
    // MARK: - QRHandle
    private func gotoQRHandle(_ message: String?) {
        qrScanManager?.stopQRScanning()
        let qrHandleVC = QRHandleViewController()
        self.navigationController?.pushViewController(qrHandleVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
