//
//  TouchIDHandler.swift
//  TouchIDDemo
//
//  Created by 黎明 on 2017/7/31.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit
import LocalAuthentication

let ENTER_BACKGROUND_TIME = "enter_background_time"

class TouchIDHandler {
    class func handlerTouchID() {
        
        let laContext = LAContext()
        laContext.localizedFallbackTitle = "输入密码"
        laContext.localizedCancelTitle = "取消"
        
        var requestError: NSError? = nil
        
        if laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &requestError) {
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "通过Home键验证已有的手机指纹", reply: { (result, error) in
                if result {
                    
                } else {
                    if let laError = error as? LAError {
                        switch laError.code {
                        case .userCancel:
                            print("userCancel")
                        case .userFallback:
                            print("userFallback")
                        case .systemCancel:
                            print("systemCancel")
                        default:
                            break
                        }
                    }
                }
                print("result: \(result), error: \(String(describing: error))")
            })
        } else {
            
        }
    }
    
    class func checkIsShowTouchID() -> Bool {
        if #available(iOS 8.0, *) {
            let currentDate = Date().timeIntervalSince1970
            let enterBGTime = readEnterBackgroundTime()
            if currentDate - enterBGTime > 20 {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    class func writeEnterBackgroundTime() {
        let time = Date().timeIntervalSince1970
        UserDefaults.standard.set(time, forKey: ENTER_BACKGROUND_TIME)
        UserDefaults.standard.synchronize()
    }
    
    class func readEnterBackgroundTime() -> TimeInterval {
        if let time = UserDefaults.standard.value(forKey: ENTER_BACKGROUND_TIME) as? TimeInterval {
            return time
        } else {
            return 0
        }
    }
}


