//
//  CustomDefine.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/14.
//  Copyright © 2017年 黎明. All rights reserved.
//

import Foundation

//屏幕适配
let SCREEN_FRAME = UIScreen.main.bounds

let SCREEN_WIDTH = UIScreen.main.bounds.width

let SCREEN_HEIGHT = UIScreen.main.bounds.height

let SCALE = SCREEN_WIDTH / 375.0

let STATUSBAR_HEIGHT: CGFloat = 20.0

let NAVBAR_HEIGHT: CGFloat = 44.0

let STATUS_NAV_HEIGHT: CGFloat = 64.0

let TABBAR_HEIGHT: CGFloat = 49.0

func SizeFloat(_ a: CGFloat) -> CGFloat {
    return (a / 2.0) * SCALE
}

//系统
let IS_IOS8 = (UIDevice.current.systemVersion as NSString).doubleValue >= 8.0

let IS_IOS9 = (UIDevice.current.systemVersion as NSString).doubleValue >= 9.0

let IS_IOS10 = (UIDevice.current.systemVersion as NSString).doubleValue >= 10.0

//是否高清屏
let isRetina = UIScreen.main.scale > 1.0

//是否iPad
let isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad

//是否iPhone
let isPhone = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone

//path
let DOCUMENT_PATH = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

let CACHES_PATH = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]

//是否模拟器
func isSimulator() -> Bool {
    var isSim = false
    #if arch(i386) || arch(x86_64)
        isSim = true
    #endif
    return isSim
}

//log
func DLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent),\(method)[\(line)]:\(message)")
    #endif
}

func FollowBugLog(file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent),\(method)[\(line)]")
    #endif
}
