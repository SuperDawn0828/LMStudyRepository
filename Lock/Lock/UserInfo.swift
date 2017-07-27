//
//  UserInfo.swift
//  Lock
//
//  Created by 黎明 on 2017/7/26.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

final class UserInfo: NSObject {
    
    static let userInfo = UserInfo()
    
    private let lockQueue = DispatchQueue(label: "com.lock.lockqueue", attributes: .concurrent)
    
    override init() {
        super.init()

    }
    
    func writeData(_ string: String) {
        __dispatch_barrier_async(lockQueue) {
            UserDefaults.standard.set(string, forKey: "lock_value")
            UserDefaults.standard.synchronize()
        }
    }
    
    func readData() -> String? {
        var string: String?
        lockQueue.sync {
            string = UserDefaults.standard.value(forKey: "lock_value") as? String
        }
        return string
    }
    
    func start() {
        __dispatch_after(__dispatch_time(dispatch_time_t(DispatchTime.now().rawValue), 5), __dispatch_get_global_queue(0, 0)) {
            
        }
    }
}
