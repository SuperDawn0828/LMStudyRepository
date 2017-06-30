//
//  FileHelper.swift
//  Swift-Util
//
//  Created by 黎明 on 2017/6/9.
//  Copyright © 2017年 黎明. All rights reserved.
//

import Foundation

//获取document路径
func DocumnetPath() -> String {
    let directorys = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    return  directorys[0]
}

//创建文件夹，在某个路径下面
func CretaeFileDirectory(_ path: String) -> Bool {
    let fileManager = FileManager.default
    var isDir: ObjCBool = false
    let isDirExist = fileManager.fileExists(atPath: path, isDirectory: &isDir)
    if !(isDir.boolValue && isDirExist) {
        do {
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch {
            return false
        }
    } else {
        return true
    }
}

//文件是否存在
func FileIsExist(_ filePath: String) -> Bool {
    let fileManager = FileManager.default
    let isDirExist = fileManager.fileExists(atPath: filePath)
    if  isDirExist {
        return true
    } else {
        return false
    }
}

//获取一个文件的路径
func GetFilePath(_ fileName: String, from path: String) -> String {
    let filePath = path.appending("/\(fileName)")
    return filePath
}

//保存文件到一个路径下面
func SaveFile(_ data: Data?, to path: String) -> Bool {
    let fileManager = FileManager.default
    return fileManager.createFile(atPath: path, contents: data, attributes: nil)
}

//删除文件
func DeleteFile(_ path: String) -> Bool{
    let fileManager = FileManager.default
    do {
        try fileManager.removeItem(atPath: path)
        return true
    } catch {
        return false
    }
}

//读取文件内容
func ReadFile(_ filePath: String) -> Data? {
    let fileManager = FileManager.default
    return fileManager.contents(atPath: filePath)
}

//获取文件路径，返回为文件名数组
func GetFileList(_ filePath: String) -> [String]? {
    let fileManager = FileManager.default
    return try? fileManager.contentsOfDirectory(atPath: filePath)
}
