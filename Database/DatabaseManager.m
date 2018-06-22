//
//  DatabaseManager.m
//  Sihaihuacai
//
//  Created by 黎明 on 2017/10/21.
//  Copyright © 2017年 Sihaihuacai. All rights reserved.
//

#import "DatabaseManager.h"
#import "FMDB.h"

@implementation DatabaseItem

@end

static NSString *const databaseDoucument = @"database";

static NSString *const default_database_name = @"database.sqlite";

static NSString *const default_table_name = @"tableName";

static NSString *const create_table_sql = @"create table if not exists %@ (id text primary key not null, value text not null, createTime text not null)";

static NSString *const replace_table_sql = @"replace into %@ (id, value, createTime) values (?, ?, ?)";

static NSString *const quety_all_sql = @"select * from %@";

static NSString *const quety_items_sql = @"select * from %@ where id in (%@)";

static NSString *const quety_item_sql = @"select * from %@ where id = ?";

static NSString *const delete_item_sql = @"delete from %@ where id = ?";

static NSString *const drop_item_sql = @"drop table %@";

@interface DatabaseManager()

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

@end

@implementation DatabaseManager

+ (instancetype)manager:(NSString *)databaseName
{
    return [[DatabaseManager alloc] initWithDatabaseName:databaseName];
}

- (instancetype)init
{
    return [self initWithDatabaseName:nil];
}

- (instancetype)initWithDatabaseName:(NSString *)databaseName
{
    self = [super init];
    if (self) {
        if (self.dbQueue != nil) {
            [self close];
        }
        
        if (databaseName == nil || databaseName.length <= 0 || [databaseName isKindOfClass:[NSNull class]]) {
            databaseName = default_database_name;
        }
        
        NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *directoryPath = [document stringByAppendingPathComponent:databaseDoucument];
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];;
        NSString *dbPath = [directoryPath stringByAppendingPathComponent:databaseName];
        NSLog(@"Database path is: %@", dbPath);
        self.dbQueue = [[FMDatabaseQueue alloc] initWithPath:dbPath];
    }
    return self;
}

- (BOOL)createTableWithName:(NSString *)tableName
{
    if (tableName == nil) {
        tableName = default_table_name;
    }
    NSString *sql = [NSString stringWithFormat:create_table_sql, tableName];
    
    __block BOOL result = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql];
    }];
    if (!result) {
        NSLog(@"Error: create table error");
    }
    return result;
}

- (BOOL)writeValue:(id)value Key:(NSString *)key toTable:(NSString *)tableName
{
    if (tableName == nil) {
        tableName = default_table_name;
    }
    
    NSDate *createTime = [NSDate date];
    NSString *sql = [NSString stringWithFormat:replace_table_sql, tableName];
    __block BOOL result = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql, key, value, createTime];
    }];
    return result;
}

- (DatabaseItem *)readValueWithKey:(NSString *)key fromTable:(NSString *)tableName
{
    if (tableName == nil) {
        tableName = default_table_name;
    }
    
    NSString *sql = [NSString stringWithFormat:quety_item_sql, tableName];
    __block id value = nil;
    __block NSDate *createTime = nil;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:sql, key];
        if ([resultSet next]) {
            value = [resultSet dataForColumn:@"value"];
            createTime = [resultSet dateForColumn:@"createTime"];
        }
        [resultSet close];
    }];
    
    DatabaseItem *item = [[DatabaseItem alloc] init];
    item.key = key;
    item.value = value;
    item.creatTime = createTime;
    return item;
    
}

- (NSArray<DatabaseItem *> *)readValuesWithKeys:(NSArray *)keys fromTable:(NSString *)tableName
{
    if (tableName == nil) {
        tableName = default_table_name;
    }
    
    NSMutableArray *newKeys = [NSMutableArray array];
    for (NSString *key in keys) {
        NSString *newKey = [NSString stringWithFormat:@"'%@'", key];
        [newKeys addObject:newKey];
    }
    NSString *key = [newKeys componentsJoinedByString:@", "];
    
    NSString *sql = [NSString stringWithFormat:quety_items_sql, tableName, key];
    __block NSMutableArray *result = [NSMutableArray array];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            DatabaseItem *item = [[DatabaseItem alloc] init];
            item.key = [resultSet stringForColumn:@"id"];
            item.value = [resultSet dataForColumn:@"value"];
            item.creatTime = [resultSet dateForColumn:@"createTime"];
            
            [result addObject:item];
        }
        [resultSet close];
    }];
    return result;
}

- (NSArray<DatabaseItem *> *)readAllValuesFromTable:(NSString *)tableName
{
    if (tableName == nil) {
        tableName = default_table_name;
    }
    
    NSString *sql = [NSString stringWithFormat:quety_all_sql, tableName];
    __block NSMutableArray *result = [NSMutableArray array];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            DatabaseItem *item = [[DatabaseItem alloc] init];
            item.key = [resultSet stringForColumn:@"id"];
            item.value = [resultSet dataForColumn:@"value"];
            item.creatTime = [resultSet dateForColumn:@"createTime"];
            
            [result addObject:item];
        }
        [resultSet close];
    }];
    return result;
}

- (BOOL)deleteValueByKey:(NSString *)key fromTable:(NSString *)tableName
{
    if (tableName == nil) {
        tableName = default_table_name;
    }
    
    NSString *sql = [NSString stringWithFormat:delete_item_sql, tableName];
    __block BOOL reslut = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        reslut = [db executeUpdate:sql, key];
    }];
    return reslut;
}

- (BOOL)dropTable:(NSString *)tableName
{
    if (tableName == nil) {
        tableName = default_table_name;
    }
    
    NSString *sql = [NSString stringWithFormat:drop_item_sql, tableName];
    __block BOOL result = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql];
    }];
    return result;
}

- (void)close
{
    [self.dbQueue close];
    self.dbQueue = nil;
}

@end
