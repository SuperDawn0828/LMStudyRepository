//
//  DatabaseManager.h
//  Sihaihuacai
//
//  Created by 黎明 on 2017/10/21.
//  Copyright © 2017年 Sihaihuacai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseItem : NSObject

@property (nonatomic, strong) NSString *key;

@property (nonatomic, strong) id value;

@property (nonatomic, strong) NSDate *creatTime;

@end

@interface DatabaseManager : NSObject

+ (instancetype)manager:(NSString *)databaseName;

- (instancetype)initWithDatabaseName:(NSString *)databaseName;

- (BOOL)createTableWithName:(NSString *)tableName;

- (BOOL)writeValue:(id)value Key:(NSString *)key toTable:(NSString *)tableName;

- (DatabaseItem *)readValueWithKey:(NSString *)key fromTable:(NSString *)tableName;

- (NSArray<DatabaseItem *> *)readValuesWithKeys:(NSArray *)keys fromTable:(NSString *)tableName;

- (NSArray<DatabaseItem *> *)readAllValuesFromTable:(NSString *)tableName;

- (int)valueNumberFromTable:(NSString *)tableName;

- (BOOL)deleteValueByKey:(NSString *)key fromTable:(NSString *)tableName;

- (BOOL)dropTable:(NSString *)tableName;

- (void)close;

@end
