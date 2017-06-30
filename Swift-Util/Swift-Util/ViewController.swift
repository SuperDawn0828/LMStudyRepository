//
//  ViewController.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/8.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LMPickerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        FollowBugLog()
//        
//        if isSimulator() {
//            print("isSimulator")
//        }
//
//        
//        if IS_IOS8 {
//            print("is_ios8'")
//        }
//        
//        if IS_IOS9 {
//            print("is_ios9")
//        }
//        
//        if IS_IOS10 {
//            print("is_ios10")
//        }
//        
//        if isRetina {
//            print("Retina")
//        }
//        
//        if isPad {
//            print("pad")
//        }
//        
//        if isPhone {
//            print("phone")
//        }
//        
//        print(DOCUMENT_PATH)
//        print(CACHES_PATH)
//        
//        print(SCREEN_FRAME)
//        print(SCREEN_WIDTH)
//        print(SCREEN_HEIGHT)
//        print(SCALE)
//        print(STATUSBAR_HEIGHT)
//        print(NAVBAR_HEIGHT)
//        print(STATUS_NAV_HEIGHT)
//        print(TABBAR_HEIGHT)
//        
//        print(SizeFloat(100))
//        
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        button.backgroundColor = .disable
        button.titleLabel?.font = .boldTitle
        button.setTitle("123", for: .normal)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        button.setEnlargeEdge(size: 100)
        view.addSubview(button)
//
//        let image = UIImage.capture(from: button)
//        let imageView1 = UIImageView()
//        imageView1.image = image
//        imageView1.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
//        view.addSubview(imageView1)
//        
//        
//        let image2 = UIImage.image(by: UIColorFromRGB(0xfe39a4))
//        let imageView2 = UIImageView()
//        imageView2.image = image2
//        imageView2.frame = CGRect(x: 100, y: 300, width: 200, height: 50)
//        view.addSubview(imageView2)
//        
//        let image3 = UIImage.image(by: UIColorFromRGB(0xe1e1e1), size: CGSize(width: 100, height: 100))
//        let imageView3 = UIImageView()
//        imageView3.image = image3
//        imageView3.frame = CGRect(x: 100, y: 400, width: 200, height: 50)
//        view.addSubview(imageView3)
//        
//        
//        let image4 = UIImage(named: "banner")
//        let imageView4 = UIImageView()
//        imageView4.image = image4?.scaleAndRatate(CGSize(width: 100, height: 50))
//        imageView4.frame = CGRect(x: 100, y: 400, width: 200, height: 50)
//        view.addSubview(imageView4)
//        
//        let tmpStr = "qwertyuiopasdfghjklzxcvbnm"
//        let str = tmpStr.subString(to: 8)
//        DLog(str)
//        
//        let s = "welcome to hangge.com"
//        let key = "67FG"
//        
//        DLog(s.md5)
//        DLog(s.hmac(.SHA1, key: key))
//        DLog(s.sha1)
//        DLog(s.sha224)
//        DLog(s.sha256)
//        DLog(s.sha384)
//        DLog(s.sha512)
//        
//        
//        let phoneNumber = "15670512816"
//        DLog("phoneNumber \(CheckPhoneNumber(phoneNumber))")
//
//        let idCard = "512501720303517"
//        
//        DLog("idCard \(CheckIdentityCardNumber(idCard))")

//        let decontent = encontent.decryptTripleDES(withKey: key)
//        DLog(decontent)
        
        
        
//        let mapManager = MapManager.manager()
//        mapManager.currentLocation(isGeocode: true) { (result, location, geoResult) in
//            
//        }
//        mapManager.currentLocation(rebackLocation: geoCodeSearch)
//        mapManager.currentLocation { (result, location) in
//            if result {
//                DLog("location:(\(location!.coordinate.longitude), \(location!.coordinate.latitude))")
//            } else {
//                
//            }
//        }
    }
    
//    func geoCodeSearch(result: Bool, location: CLLocation?) {
//        let mapManager = MapManager.manager()
//        if result {
//            mapManager.reverseGeoCodeSearch(coordinate: location!.coordinate) { (geoCodeResult) in
//                
//            }
//        }
//    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        
        let pickerView = LMPickerView([["1", "2", "3", "4", "5"], ["a", "b", "c", "d", "e", "f", "g"], ["1", "2", "3", "4", "5"]])
        pickerView.delegate = self
        pickerView.show()
        
        
//       let _ = ShareManager(shareType: .link) { () -> ShareContext in
//            var context = ShareContext()
//            context.detail = "眸瑞科技-移动现实技术"
//            context.title = "眸瑞科技"
//            context.shareLink = "http://www.mobilereality.org"
//            return context
//        }
        
//        let _ = ShareManager.init(shareType: .link, shareScencs: [.QQ, .link, .wechatSession]) { () -> ShareContext in
//            var context = ShareContext()
//            context.detail = "眸瑞科技-移动现实技术"
//            context.title = "眸瑞科技"
//            context.shareLink = "http://www.mobilereality.org"
//            return context
//        }
        
//        let twoVC = TwoViewController()
//        present(twoVC, animated: true, completion: nil)
//        
//        ShowWaitingHud()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { 
//            DismissWaitingHud()
//        }
        
//        ShowQuicklyTips(title: "123456789797878")
        
//        ShowQuicklyTips("123456789", in: view)
        
//        ShowWaitingHud("1234546788", in: view)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [unowned self] in
//            DismissWaitingHud(in: self.view)
//        }
        
//        ShowQuicklyWaitingHud()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            DismissWaitingHud()
//        }
//        
//        ShowProgressHud()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { 
//            DismissProgressHud()
//        }
        
//        ShowProgressHud(in: view)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [unowned self] in
//            DismissProgressHud(in: self.view)
//        }
        
//        ShowProgressHud(toast: "123456789", in: view)
    }
    
    func pickerView(_ pickerView: LMPickerView, certainSelected dataArray: [String]) {
        
    }
    
    func pickerView(_ pickerView: LMPickerView, updateSourceArray selectedRow: Int, inComponent component: Int) -> [String] {
        return ["as", "qw", "de", "dw", "jk"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

