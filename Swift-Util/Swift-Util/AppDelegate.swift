//
//  AppDelegate.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/8.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        NSSetUncaughtExceptionHandler(UncaughtExceptionHandler)
//        let mapManager = MapManager.manager()
//        mapManager.registerAMap(GaodeMapKey)
//        mapManager.registerBMK(BaiduMapKey)
        
        UMSocialManager.default().openLog(true)
        UMSocialManager.default().umSocialAppkey = UMAppkey
        UMSocialManager.default().setPlaform(.wechatSession, appKey: WXAppID, appSecret: WXAppKey, redirectURL: "http://mobile.umeng.com/social")
        UMSocialManager.default().setPlaform(.QQ, appKey: QQAppID, appSecret: nil, redirectURL: "http://mobile.umeng.com/social")
        
        return true
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return UMSocialManager.default().handleOpen(url)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return UMSocialManager.default().handleOpen(url)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return UMSocialManager.default().handleOpen(url)
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

