//
//  OneViewController.swift
//  IOSDetectorFaceExample
//
//  Created by 黎明 on 2017/5/15.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import CoreImage

class OneViewController: UIViewController {
    
    @IBOutlet weak var faceImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detect()
    }

    func detect() {
        guard let personciImage = CIImage(image: faceImageView.image!) else {
            return
        }
        
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: personciImage)
        
        for face in faces as! [CIFaceFeature] {
            let faceBox = UIView(frame: face.bounds)
            faceBox.layer.borderColor = UIColor.red.cgColor
            faceBox.layer.borderWidth = 1
            faceBox.backgroundColor = .clear
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
