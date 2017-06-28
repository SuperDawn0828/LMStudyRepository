//
//  QRScanManager.swift
//  IOSQRScanExample
//
//  Created by 黎明 on 2017/5/15.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import AVFoundation

protocol QRScanHanlderDelegate: NSObjectProtocol {
    func qrScanManager(_ manager: QRScanHanlder, completedScanningWithOutput output: String?)
}

class QRScanHanlder: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    private var captureDevice: AVCaptureDevice?
    private var session: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    weak var delegate: QRScanHanlderDelegate?
    
    init(_ layer: CALayer) {
        super.init()
        captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let input = try? AVCaptureDeviceInput(device: captureDevice)
        let output = AVCaptureMetadataOutput()
        
        let queue = DispatchQueue(label: "com.qrScan.queue")
        output.setMetadataObjectsDelegate(self, queue: queue)
        output.rectOfInterest = CGRect(x: 0.05, y: 0.2, width: 0.7, height: 0.6)
        
        session = AVCaptureSession()
        session?.sessionPreset = AVCaptureSessionPresetHigh
        
        if session!.canAddInput(input!) {
            session?.addInput(input)
        }
        
        if session!.canAddOutput(output) {
            session?.addOutput(output)
        }
        
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        previewLayer?.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height - 64.0)
        
        layer.insertSublayer(previewLayer!, at: 0)
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {        
        if metadataObjects.count > 0 {
            let object = metadataObjects[0] as! AVMetadataMachineReadableCodeObject            
            delegate?.qrScanManager(self, completedScanningWithOutput: object.stringValue)
        }
    }
    
    public func startQRScanning() {
        session?.startRunning()
    }
    
    public func stopQRScanning() {
        session?.stopRunning()
    }
    
    public func scaningOnTourch(_ on: Bool) {
        if captureDevice!.hasFlash {
            try? captureDevice?.lockForConfiguration()
            
            if on {
                captureDevice?.torchMode = .on
            } else {
                captureDevice?.torchMode = .off
            }
            
            captureDevice?.unlockForConfiguration()
        }
    }
}
