//
//  ViewController.m
//  DatabaseTest
//
//  Created by 黎明 on 2017/10/22.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "ViewController.h"
#import "DatabaseManager.h"

@interface ViewController ()

@property (nonatomic, strong) DatabaseManager *databaseManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)buttonAction1:(UIButton *)sender {
    self.databaseManager = [DatabaseManager manager:nil];
}

- (IBAction)buttonAction2:(UIButton *)sender {
    [self.databaseManager createTableWithName:@"database"];
}

- (IBAction)buttonAction3:(UIButton *)sender {
    static int index = 0;
    NSString *string = [NSString stringWithFormat:@"database_%d", index];
    index += 1;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [self.databaseManager writeValue:data Key:string toTable:@"database"];
}

- (IBAction)buttonAction4:(UIButton *)sender {
    static int index = 0;
    NSString *string = [NSString stringWithFormat:@"database_%d", index];
    index += 1;
    DatabaseItem *item = [self.databaseManager readValueWithKey:string fromTable:@"database"];
    NSLog(@"item -->: key is: %@, value is: %@, date is:%@", item.key, [[NSString alloc] initWithData:item.value encoding: NSUTF8StringEncoding], item.creatTime);
}

- (IBAction)buttonAction5:(UIButton *)sender {
    NSArray *array = [self.databaseManager readValuesWithKeys:@[@"database_1", @"database_2", @"database_3", @"database_4"] fromTable:@"database"];
    for (DatabaseItem *item in array) {
        NSLog(@"item -->: key is: %@, value is: %@, date is:%@", item.key, [[NSString alloc] initWithData:item.value encoding: NSUTF8StringEncoding], item.creatTime);
    }
}

- (IBAction)buttonAction6:(UIButton *)sender {
    static int index = 0;
    NSString *string = [NSString stringWithFormat:@"database_%d", index];
    index += 1;
    [self.databaseManager deleteValueByKey:string fromTable:@"database"];
}

- (IBAction)buttonAction7:(UIButton *)sender {
    NSArray *array = [self.databaseManager readValuesWithKeys:@[@"database_1", @"database_2", @"database_3", @"database_12"] fromTable:@"database"];
    for (DatabaseItem *item in array) {
        NSLog(@"item -->: key is: %@, value is: %@, date is:%@", item.key, [[NSString alloc] initWithData:item.value encoding: NSUTF8StringEncoding], item.creatTime);
    }
}


@end
