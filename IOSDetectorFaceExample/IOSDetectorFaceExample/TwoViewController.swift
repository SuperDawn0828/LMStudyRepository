//
//  TwoViewController.swift
//  IOSDetectorFaceExample
//
//  Created by 黎明 on 2017/5/15.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController {
    
    @IBOutlet weak var faceImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        detect()
    }
    
    func detect() {
        guard let personciImage = CIImage(image: faceImageView.image!) else {
            return
        }
        
        let accurcy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accurcy)
        let faces = faceDetector?.features(in: personciImage)
        
        let ciImageSize = personciImage.extent.size
        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -ciImageSize.height)
        
        for face in faces as! [CIFaceFeature] {
            var faceViewBounds = face.bounds.applying(transform)
            
            let viewSize = faceImageView.bounds.size
            let scale = min(viewSize.width / ciImageSize.width, viewSize.height / ciImageSize.height)
            let offsetX = (viewSize.width - ciImageSize.width * scale) / 2.0
            let offsetY = (viewSize.height - ciImageSize.height * scale) / 2.0
            
            faceViewBounds = faceViewBounds.applying(CGAffineTransform(scaleX: scale, y: scale))
            faceViewBounds.origin.x += offsetX
            faceViewBounds.origin.y += offsetY
            
            let faceBox = UIView(frame: faceViewBounds)
            faceBox.layer.borderWidth = 1
            faceBox.layer.borderColor = UIColor.red.cgColor
            faceImageView.addSubview(faceBox)
            
            if face.hasLeftEyePosition {
                print("Left eye bounds are \(face.leftEyePosition)")
            }
            
            if face.hasRightEyePosition {
                print("Right eye bounds are \(face.rightEyePosition)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
