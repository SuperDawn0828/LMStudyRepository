//
//  AppDelegate.swift
//  TouchIDDemo
//
//  Created by 黎明 on 2017/7/31.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        TouchIDHandler.handlerTouchID()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        TouchIDHandler.writeEnterBackgroundTime()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        if TouchIDHandler.checkIsShowTouchID() {
            TouchIDHandler.handlerTouchID()
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

