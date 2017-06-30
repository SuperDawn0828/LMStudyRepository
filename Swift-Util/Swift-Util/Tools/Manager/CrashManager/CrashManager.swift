//
//  CrashManager.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/9.
//  Copyright © 2017年 黎明. All rights reserved.
//

import Foundation

func UncaughtExceptionHandler(exception: NSException) {
    let arr = exception.callStackSymbols
    let reason = exception.reason
    let name = exception.name.rawValue
    let crash = "\r\n\r\n name:\(name) \r\n reason:\(String(describing: reason)) \r\n \(arr.joined(separator: "\r\n")) \r\n\r\n"
    if CreateCrashDirectory() {
        SaveCrash(crash)
    }
}

func CreateCrashDirectory() -> Bool {
    let pathcaches = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
    let cachesDirectory = pathcaches[0]
    let crashPath = cachesDirectory.appending("/log")
    
    let fileManager = FileManager.default
    
    var isDir: ObjCBool = false
    let isDirExist = fileManager.fileExists(atPath: crashPath, isDirectory: &isDir)
    if !(isDir.boolValue && isDirExist) {
        do {
            try fileManager.createDirectory(atPath: crashPath, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch {
            return false
        }
    } else {
        return true
    }
}

func SaveCrash(_ crash: String) {
    let pathcaches = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
    let cachesDirectory = pathcaches[0]
    let crashPath = cachesDirectory.appending("/log")
    
    let fileManager = FileManager.default
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = Date()
    let dateString = formatter.string(from: date)
    let logFileName = "\(dateString).log"
    
    let logPath = crashPath.appending("/\(logFileName)")
    let isSuccess = fileManager.createFile(atPath: logPath, contents: nil, attributes: nil)
    if isSuccess {
       try? crash.write(toFile: logPath, atomically: true, encoding: .utf8)
    }
}

func CrashFileList() -> [String] {
    let pathcaches = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
    let cachesDirectory = pathcaches[0]
    let crashPath = cachesDirectory.appending("/log")
    
    let fileManager = FileManager.default
    
    var logFiles: [String] = []
    let fileList = try? fileManager.contentsOfDirectory(atPath: crashPath)
    if let list = fileList {
        for fileName in list {
            if let _ = fileName.range(of: ".log") {
                logFiles.append(fileName)
            }
        }
    }
    
    return logFiles
}

func ReadCrash(_ fileName: String) -> String? {
    let pathcaches = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
    let cachesDirectory = pathcaches[0]
    let crashPath = cachesDirectory.appending("/log")
    
    let filePath = crashPath.appending("/\(fileName)")
    let content = try? String(contentsOfFile: filePath, encoding: .utf8)
    return content
}

func DeleteCrash(_ fileName: String) {
    let pathcaches = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
    let cachesDirectory = pathcaches[0]
    let crashPath = cachesDirectory.appending("/log")
    
    let filePath = crashPath.appending("/\(fileName)")
    let fileManager = FileManager.default
    try? fileManager.removeItem(atPath: filePath)
}
