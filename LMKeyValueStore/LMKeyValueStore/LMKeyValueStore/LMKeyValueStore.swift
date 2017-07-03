//
//  LMKeyValueStore.swift
//  LMKeyValueStore
//
//  Created by 黎明 on 2017/6/30.
//  Copyright © 2017年 黎明. All rights reserved.
//

import UIKit

/// 数据库默认名
private let DEFAULT_TABLE_NAME = "database.sqlite"

/// 创建表
private let CREATE_TABLE_SQL = "create table if not exists %@ (id text primary key not null, json text not null, createTime text not null)"

/// 插入数据或者更新数据
private let REPLACE_TABLE_SQL = "replace into %@ (id, json, createTime) values ('%@', '%@', %f)"

/// 查询所有数据
private let QUERY_ALL_SQL = "select * from %@"

/// 查询单条数据
private let QUERY_ITEM_SQL = "select * from %@ where id = %@ limit 1"

/// 批量查询数据
private let QUERY_ITEMS_SQL = "select * from %@ where id in (%@)"

/// 数据库表中数据的总量
private let COUNT_ITEM_SQL = "select count(*) as count from %@"

/// 删除表中的所有数据
private let CLEAR_ALL_SQL = "delete from %@"

/// 删除数据库表中单条数据
private let DELETE_ITEM_SQL = "delete from %@ where id = %@"

/// 批量删除表中的数据
private let DELETE_ITEMS_SQL = "delete from %@ where id in (%@)"

/// 删除表
private let DROP_TABLE_SQL = "drop table %@"

/// log打印
///
/// - Parameter message: 需要打印的信息
func LMKeyValueLog<T>(_ message: T) {
    #if DEBUG
        print(message)
    #endif
}


/// 数据结构
struct LMKeyValueItem {
    
    var itemId: String?
    
    var itemObject: Any?
    
    var createTime: Double?
    
    func description() {
        LMKeyValueLog("KeyValueItem: id = \(String(describing: itemId)), itemObject = \(String(describing: itemObject)), createTime = \(String(describing: createTime))")
    }
}

class LMKeyValueStore: NSObject {
    
    /// 数据库队列
    fileprivate var dbQueue: FMDatabaseQueue?
    
    //MARK: - 构造方法
    private override init() {
        super.init()
     }
    
    convenience init?(databasePath dbPath: String) {
        guard LMKeyValueStore.checkTableNameOrPath(dbPath) else {
            LMKeyValueLog("Error: database path error")
            return nil
        }
        
        self.init()
         if dbQueue != nil {
            close()
        }
        LMKeyValueLog("DatabasePath: \(dbPath)")
        dbQueue = FMDatabaseQueue(path: dbPath)
    }
    
    convenience init?(databaseName dbNmae: String = DEFAULT_TABLE_NAME) {
        guard LMKeyValueStore.checkTableNameOrPath(dbNmae) else {
            LMKeyValueLog("Error: database name error")
            return nil
        }
        
        let document = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let dbPath = String(format: "%@/%@", document, dbNmae);
        self.init(databasePath: dbPath)
    }
    
    // MARK: - Private Method
    
    /// 检测表名和数据库
    ///
    /// - Parameter tableName: 表名
    /// - Returns: true 表名和数据库合法， false 表名和数据库不合法
    fileprivate func checkDatabaseQueueAndTableName(_ tableName: String) -> Bool {
        guard LMKeyValueStore.checkTableNameOrPath(tableName) else {
            LMKeyValueLog("Error: Database name error")
            return false
        }
        
        guard let _ = dbQueue else {
            LMKeyValueLog("Error: DatabaseQueue is nil")
            return false
        }
        
        return true
    }
    
    /// 将字典或数组转换为json字符串
    ///
    /// - Parameter object: 字典或者数据
    /// - Returns: json字符串
    fileprivate func objectToJsonString(_ object: Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) else {
            LMKeyValueLog("Error: data is invalid")
            return nil
        }
        
        guard let jsonString = String(data: data, encoding: .utf8) else {
            LMKeyValueLog("Error: json error")
            return nil
        }
        
        return jsonString
    }
    
    /// 将json字符串转换为字典或数字
    ///
    /// - Parameter jsonString: json字符串
    /// - Returns: 转换后的到的数组或字典
    fileprivate func jsonStringToObject(_ jsonString: String?) -> Any? {
        guard let json = jsonString else {
            LMKeyValueLog("Error: json is nil")
            return nil
        }
        
        guard let data = json.data(using: .utf8) else {
            LMKeyValueLog("Error: data error")
            return nil
        }
        
        let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        
        return object
    }
    
    /// 检测表名或路径
    class fileprivate func checkTableNameOrPath(_ string: String) -> Bool {
        if string.contains(" ") {
            return false
        }
        return true
    }
}

//MARK: - Database Method
extension LMKeyValueStore {
    
    /// 创建表
    ///
    /// - Parameter tableName: 表名
    func createTable(with tableName: String) {
        if !checkDatabaseQueueAndTableName(tableName) {
            return
        }
        
        dbQueue?.inDatabase { (db) in
            guard let database = db else {
                LMKeyValueLog("Error: Database is nil")
                return
            }
            
            let sql = String(format: CREATE_TABLE_SQL, tableName)
            let result = database.executeUpdate(sql, withArgumentsIn: nil)
            if !result {
                LMKeyValueLog("Error: Create table is failed")
            }
        }
    }
    
    /// 表是否存在
    ///
    /// - Parameter tableName: 表名
    /// - Returns: true 表存在，false 表不存在
    func tebleExist(tableName: String) -> Bool {
        var result = false
        
        if !checkDatabaseQueueAndTableName(tableName) {
            return result
        }
        
        dbQueue?.inDatabase { (db) in
            if let database = db {
                result = database.tableExists(tableName)
            } else {
                LMKeyValueLog("Error: Database is nil")
                result = false
            }
        }
        
        return result
    }
    
    /// 清空表中的所有数据
    ///
    /// - Parameter tableName: 表名
    func clearTable(tableName: String) {
        if !checkDatabaseQueueAndTableName(tableName) {
            return
        }
        
        dbQueue?.inDatabase { (db) in
            guard let database = db else {
                LMKeyValueLog("Error: Database is nil")
                return
            }
            
            let sql = String(format: CLEAR_ALL_SQL, tableName)
            let result = database.executeUpdate(sql, withArgumentsIn: nil)
            if !result {
                LMKeyValueLog("Error: Clear table is failed")
                
            }
        }
    }
    
    /// 删除表
    ///
    /// - Parameter tableName: 表名
    func dropTable(tableName: String) {
        if !checkDatabaseQueueAndTableName(tableName) {
            return
        }
        
        dbQueue?.inDatabase { (db) in
            guard let database = db else {
                LMKeyValueLog("Error: Database is nil")
                return
            }
            
            let sql = String(format: DROP_TABLE_SQL, tableName)
            let result = database.executeUpdate(sql, withArgumentsIn: nil)
            if !result {
                LMKeyValueLog("Error: Delete table is failed")
                
            }
        }
    }
    
    /// 获取数据库表中的数据量
    ///
    /// - Parameter tableName: 表名
    /// - Returns: 数据量
    func countTableItem(_ tableName: String) -> Int {
        if !checkDatabaseQueueAndTableName(tableName) {
            return 0
        }
        
        var count = 0
        
        dbQueue?.inDatabase { (db) in
            do {
                guard let database = db else {
                    LMKeyValueLog("Error: Database is nil")
                    return
                }
                
                let sql = String(format: COUNT_ITEM_SQL, tableName)
                let resultSet = try database.executeQuery(sql, values: nil)
                if resultSet.next() {
                    count = Int(resultSet.unsignedLongLongInt(forColumn: "count"))
                } else {
                    LMKeyValueLog("Error: No item")
                }
            } catch {
                LMKeyValueLog("Error: Read table item number is failed")
            }
        }
        return count
    }
    
    /// 关闭数据库
    func close() {
        dbQueue?.close()
        dbQueue = nil
    }
}

//MARK: - Read Or Write Method
extension LMKeyValueStore {
    
    /// 将数据写入数据库中
    ///
    /// - Parameters:
    ///   - object: 需要存储的数据（为数组或者字典）
    ///   - objectId: 表的主键
    ///   - tableName: 表名
    func writeObject<C: Collection>(_ object: C, with objectId: String, intoTable tableName: String)  {
        if !checkDatabaseQueueAndTableName(tableName) {
            return
        }
        
        guard let jsonString = objectToJsonString(object) else {
            return
        }
        
        let createTime = Date().timeIntervalSince1970
        
        dbQueue?.inDatabase { (db) in
            guard let database = db else {
                LMKeyValueLog("Error: Database is nil")
                return
            }
            
            let sql = String(format: REPLACE_TABLE_SQL, tableName, objectId, jsonString, createTime)
            let result = database.executeUpdate(sql, withArgumentsIn: nil)
            if !result {
                LMKeyValueLog("Error: Insert Or Update table is failed")
            }
        }
    }
    
    /// 读取数据库存储的数据（不包含主键、存储时间）
    ///
    /// - Parameters:
    ///   - objectId: 表的主键
    ///   - tableName: 表名
    /// - Returns: 读取到的数据库数据
    func readObject(by objectId: String, from tableName: String) -> Any? {
        if let keyValueItem = readKeyValue(by: objectId, from: tableName) {
            return keyValueItem.itemObject
        }
        return nil
    }
    
    /// 读取数据库表中的单条数据
    ///
    /// - Parameters:
    ///   - objectId: 表的主键
    ///   - tableName: 表名
    /// - Returns: 数据库的数据
    func readKeyValue(by objectId: String, from tableName: String) -> LMKeyValueItem? {
        if !checkDatabaseQueueAndTableName(tableName) {
            return nil
        }
        
        var jsonString: String?
        var createTime: Double?
        
        dbQueue?.inDatabase { (db) in
            do {
                guard let database = db else {
                    LMKeyValueLog("Error: Database is nil")
                    return
                }
                
                let sql = String(format: QUERY_ITEM_SQL, tableName, objectId)
                let resultSet = try database.executeQuery(sql, values: nil)
                
                if resultSet.next() {
                    jsonString = resultSet.string(forColumn: "json")
                    createTime = resultSet.double(forColumn: "createTime")
                } else {
                    LMKeyValueLog("Error: Data is not exist")
                }
                
                resultSet.close()
            } catch {
                LMKeyValueLog("Error: Read table data is failed")
            }
        }
        
        let object = jsonStringToObject(jsonString)
        
        let keyValueItem = LMKeyValueItem(itemId: objectId, itemObject: object, createTime: createTime)
        
        return keyValueItem
    }
    
    /// 读取数据库表中的所有数据
    ///
    /// - Parameter tableName: 表名
    /// - Returns: 数据库表中的所有数据
    func readAllItems(from tableName: String) -> [LMKeyValueItem]? {
        if !checkDatabaseQueueAndTableName(tableName) {
            return nil
        }
        
        var items: [LMKeyValueItem] = []
        
        dbQueue?.inDatabase { (db) in
            do {
                guard let database = db else {
                    LMKeyValueLog("Error: Database is nil")
                    return
                }
                
                let sql = String(format: QUERY_ALL_SQL, tableName)
                let resultSet = try database.executeQuery(sql, values: nil)
                
                while resultSet.next() {
                    let jsonString = resultSet.string(forColumn: "json")
                    let objectId = resultSet.string(forColumn: "id")
                    let createTime = resultSet.double(forColumn: "createTime")
                    items.append(LMKeyValueItem(itemId: objectId!, itemObject: jsonString!, createTime: createTime))
                }
                
                resultSet.close()
                
            } catch {
                LMKeyValueLog("Error: Read table data is failed")
            }
        }
        
        for (index, keyValueItem) in items.enumerated() {
            guard let object = jsonStringToObject(keyValueItem.itemObject as? String) else {
                continue
            }
            items[index] = LMKeyValueItem(itemId: keyValueItem.itemId, itemObject: object, createTime: keyValueItem.createTime)
        }
        
        return items
    }
    
    /// 批量读取数据库表中的数据
    ///
    /// - Parameters:
    ///   - objectIds: 表的主键数组
    ///   - tableName: 表名
    /// - Returns: 批量读取到的数据库数据
    func readItems(by objectIds: [String], from tableName: String) -> [LMKeyValueItem]? {
        if !checkDatabaseQueueAndTableName(tableName) {
            return nil
        }
        
        let objectIdsStr = objectIds.joined(separator: " , ")
        
        var items: [LMKeyValueItem] = []
        
        dbQueue?.inDatabase { (db) in
            do {
                guard let database = db else {
                    LMKeyValueLog("Error: Database is nil")
                    return
                }
                
                let sql = String(format: QUERY_ITEMS_SQL, tableName, objectIdsStr)
                let resultSet = try database.executeQuery(sql, values: nil)
                
                while resultSet.next() {
                    let jsonString = resultSet.string(forColumn: "json")
                    let objectId = resultSet.string(forColumn: "id")
                    let createTime = resultSet.double(forColumn: "createTime")
                    items.append(LMKeyValueItem(itemId: objectId!, itemObject: jsonString!, createTime: createTime))
                }
                
                resultSet.close()
                
            } catch {
                LMKeyValueLog("Error: Read table data is failed")
            }
        }
        
        for (index, keyValueItem) in items.enumerated() {
            guard let object = jsonStringToObject(keyValueItem.itemObject as? String) else {
                continue
            }
            items[index] = LMKeyValueItem(itemId: keyValueItem.itemId, itemObject: object, createTime: keyValueItem.createTime)
        }
        
        return items
    }
    
    /// 将字符串存储到数据库中
    ///
    /// - Parameters:
    ///   - string:
    ///   - objectId: 表的主键
    ///   - tableName: 表名
    func writeString(_ string: String, with objectId: String, into tableName: String) {
        writeObject([string], with: objectId, intoTable: tableName)
    }
    
    /// 读取数据库表中存储的字符串
    ///
    /// - Parameters:
    ///   - objectId: 表的主键
    ///   - tableName: 表名
    /// - Returns: 表中存储的字符串
    func readString(by objectId: String, from tableName: String) -> String? {
        guard let keyValueItem = readKeyValue(by: objectId, from: tableName) else {
            return nil
        }
        
        if let array = keyValueItem.itemObject as? [String] {
            return array[0]
        }
        
        return nil
    }
}

// MARK: - Delete Data Method
extension LMKeyValueStore {
    
    /// 删除数据库表中的数据
    ///
    /// - Parameters:
    ///   - objectId: 表的主键
    ///   - tableName: 表名
    func deleteItem(by objectId: String, from tableName: String) {
        if !checkDatabaseQueueAndTableName(tableName) {
            return
        }
        
        dbQueue?.inDatabase { (db) in
            guard let database = db else {
                LMKeyValueLog("Error: Database is nil")
                return
            }
            
            let sql = String(format: DELETE_ITEM_SQL, tableName, objectId)
            let result = database.executeUpdate(sql, withArgumentsIn: nil)
            
            if !result {
                LMKeyValueLog("Error: Delete item is failed")
            }
        }
    }
    
    /// 删除数据库表中的数据（批量删除）
    ///
    /// - Parameters:
    ///   - objectIds: 表的主键数组
    ///   - tableName: 表名
    func deleteItems(by objectIds: [String], from tableName: String) {
        if !checkDatabaseQueueAndTableName(tableName) {
            return
        }
        
        let objectIdStr = objectIds.joined(separator: " , ")
        
        dbQueue?.inDatabase { (db) in
            guard let database = db else {
                LMKeyValueLog("Error: Database is nil")
                return
            }
            
            let sql = String(format: DELETE_ITEMS_SQL, tableName, objectIdStr)
            let result = database.executeUpdate(sql, withArgumentsIn: nil)
            
            if !result {
                LMKeyValueLog("Error: Delete items is failed")
            }
        }
    }
}

