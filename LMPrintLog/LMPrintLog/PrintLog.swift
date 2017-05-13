//
//  PrintLog.swift
//  LMPrintLog
//
//  Created by apple on 2017/5/5.
//  Copyright © 2017年 apple. All rights reserved.
//

import Foundation

func DLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)],\(method):\(message)")
    #endif
}

func FollowBugLog(file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)],\(method)")
    #endif
}

