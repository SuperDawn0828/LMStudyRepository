//
//  MessageCenterDatabase.swift
//  LaoZicloudApp
//
//  Created by 黎明 on 2017/7/18.
//  Copyright © 2017年 mr123456. All rights reserved.
//

import UIKit
import FMDB

/// 数据库默认名
private let DEFAULT_DATABASE_NAME   = "database.sqlite"

/// 表的默认名
private let DEFAULT_TABLE_NAME      = "MessageCenter"

/// 创建表
private let CREATE_TABLE_SQL        = "create table if not exists %@ (id text primary key not null, value text not null, isRead boolean not null,createTime text not null)"

/// 插入数据或者更新数据
private let REPLACE_TABLE_SQL       = "replace into %@ (id, value, isRead, createTime) values (?, ?, ?, ?)"

/// 跟新表中的字段
private let UPDATE_ITEMVALUE_SQL    = "update %@ set %@ = ? where id = ?"

/// 批量查询数据
private let QUERY_ITEMS_SQL         = "select * from %@ order by createTime desc limit 10 offset ?"

/// 删除数据库表中单条数据
private let DELETE_ITEM_SQL         = "delete from %@ where id = ?"

/// 删除数据库超多50条后的数据
private let DELETE_OVERFLOW_SQL     = "delete from %@ where (select count(*) from %@) > 15 and id in (select id from %@ order by createTime desc limit (select count(*) from %@) offset 15)"

/// 删除表
private let DROP_TABLE_SQL          = "drop table %@"

/// 数据库表中数据数量
private let COUNT_ITEM_SQL          = "select count(*) as count from %@ where %@ = ?"

/// 数据结构
struct MessageCenterItem {
    
    var id: String!
    
    var value: Any!
    
    var isRead: Bool!
    
    var createTime: Double!
}

class MessageCenterDatabase: NSObject {
    
    fileprivate var dbQueue: FMDatabaseQueue!
    
    override init() {
        super.init()
        
        if dbQueue != nil {
            close()
        }
        
        let document = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let dbPath = String(format: "%@/%@", document, DEFAULT_DATABASE_NAME);
        DLog(dbPath)
        dbQueue = FMDatabaseQueue(path: dbPath)
    }
    
    func createTable() {
        dbQueue.inDatabase { (database) in
            let sql = String(format: CREATE_TABLE_SQL, DEFAULT_TABLE_NAME)
            let result = database.executeUpdate(sql, withArgumentsIn: [])
            if !result {
                DLog("Error: Create table is failed")
            }
        }
    }
    
    func writeValue(_ value: [String: Any], with id: String)  {
        
        guard let jsonString = JsonStringFromDictionaryOrArray(value) else {
            return
        }
        
        let createTime = value["createDate"]!
        
        dbQueue.inDatabase { (database) in
            let sql = String(format: REPLACE_TABLE_SQL, DEFAULT_TABLE_NAME)
            let result = database.executeUpdate(sql, withArgumentsIn: [id, jsonString, false, createTime])
            if !result {
                DLog("Error: Insert Or Update table is failed")
            }
        }
    }
    
    func updateIsReadValue(_ id: String, isRead: Bool) {
        dbQueue.inDatabase { (database) in
            let sql = String(format: UPDATE_ITEMVALUE_SQL, DEFAULT_TABLE_NAME, "isRead")
            let result = database.executeUpdate(sql, withArgumentsIn: [isRead, id])
            if !result {
                DLog("Error: Update value is failed")
            }
        }
    }
    
    func readValues(by currentPage: Int) -> [MessageCenterItem] {
        
        var values: [MessageCenterItem] = []
        
        dbQueue.inDatabase { (database) in
            do {
                let sql = String(format: QUERY_ITEMS_SQL, DEFAULT_TABLE_NAME)
                let resultSet = try database.executeQuery(sql, values: [(currentPage - 1) * 10])
                while resultSet.next() {
                    let value = resultSet.string(forColumn: "value")
                    let id = resultSet.string(forColumn: "id")
                    let createTime = resultSet.double(forColumn: "createTime")
                    let isRead = resultSet.bool(forColumn: "isRead")
                    values.append(MessageCenterItem(id: id, value: value, isRead: isRead, createTime: createTime))
                }
                
                resultSet.close()
                
            } catch {
                DLog("Error: Read table data is failed")
            }
        }
        
        for (index, item) in values.enumerated() {
            guard let value = JsonStringToDictionaryOrArray(item.value as! String) else {
                continue
            }
            values[index] = MessageCenterItem(id: item.id, value: value, isRead: item.isRead, createTime: item.createTime)
        }
        
        return values
    }
    
    func countIsRead() -> Int {
        var count = 0
        
        dbQueue.inDatabase { (database) in
            do {
                let sql = String(format: COUNT_ITEM_SQL, DEFAULT_TABLE_NAME, "isRead")
                let resultSet = try database.executeQuery(sql, values: [0])
                if resultSet.next() {
                    count = Int(resultSet.unsignedLongLongInt(forColumn: "count"))
                } else {
                    DLog("Error: No item")
                }
            } catch {
                DLog("Error: Read table item number is failed")
            }
        }
        return count
    }
    
    func deleteValue(by id: String) {
        dbQueue.inDatabase { (database) in
            let sql = String(format: DELETE_ITEM_SQL, DEFAULT_TABLE_NAME)
            let result = database.executeUpdate(sql, withArgumentsIn: [id])
            if !result {
                DLog("Error: Delete item is failed")
            }
        }
    }
    
    func deleteOverflowValues() {
        dbQueue.inDatabase { (database) in
            let sql = String(format: DELETE_OVERFLOW_SQL, DEFAULT_TABLE_NAME, DEFAULT_TABLE_NAME, DEFAULT_TABLE_NAME, DEFAULT_TABLE_NAME)
            let result = database.executeUpdate(sql, withArgumentsIn: [])
            if !result {
                DLog("Error: Delete item is failed")
            }
        }
    }
    
    func dropTable() {
        dbQueue.inDatabase { (database) in
            let sql = String(format: DROP_TABLE_SQL, DEFAULT_TABLE_NAME)
            let result = database.executeUpdate(sql, withArgumentsIn: [])
            if !result {
                DLog("Error: Delete table is failed")
                
            }
        }
    }
    
    /// 关闭数据库
    func close() {
        dbQueue.close()
        dbQueue = nil
    }
}

//log
func DLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent): \(method): (\(line)): \(message)")
    #endif
}

//json数据转换
func JsonStringToDictionaryOrArray(_ jsonString: String) -> Any? {
    let jsonData = jsonString.data(using: .utf8)
    if let data = jsonData {
        do {
            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return result
        } catch {
            return nil
        }
    } else {
        return nil
    }
}

func JsonStringFromDictionaryOrArray(_ object: Any) -> String? {
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
        let jsonString = String(data: jsonData, encoding: .utf8)
        return jsonString
    } catch {
        return nil
    }
}

