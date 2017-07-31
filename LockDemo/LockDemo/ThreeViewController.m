//
//  ThreeViewController.m
//  LockDemo
//
//  Created by 黎明 on 2017/7/24.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()

@property (nonatomic, strong) NSCondition *condition;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.condition = [[NSCondition alloc] init];
    
    self.array = [NSMutableArray array];
    
    self.semaphore = dispatch_semaphore_create(1);
    
}

- (IBAction)buttonOneAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakSelf.condition lock];
        sleep(1);
        NSLog(@"[condition lock]");
        [weakSelf.array addObject:[NSString stringWithFormat:@"lock index"]];
        [weakSelf.condition signal];
        [weakSelf.condition unlock];
    });
    
}

- (IBAction)buttonTwoAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakSelf.condition lock];
        sleep(5);
        if (weakSelf.array.count <= 0) {
            NSLog(@"等待");
            [weakSelf.condition wait];
        }
        sleep(1);
        NSLog(@"取数据");
        NSLog(@"condiction lock content: %@", [weakSelf.array firstObject]);
        [weakSelf.array removeObjectAtIndex:0];
        [weakSelf.condition unlock];
    });
    
}

- (IBAction)buttonThreeAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(weakSelf.semaphore, DISPATCH_TIME_FOREVER);
        for (NSInteger index = 0; index < 10; index ++) {
            sleep(5);
            NSLog(@"button three index: %ld, current thread: %@", index, [NSThread currentThread]);
        }
        dispatch_semaphore_signal(weakSelf.semaphore);
    });
}

- (IBAction)buttonFourAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(weakSelf.semaphore, DISPATCH_TIME_FOREVER);
        for (NSInteger index = 0; index < 10; index ++) {
            sleep(1);
            NSLog(@"button four index: %ld, current thread: %@", index, [NSThread currentThread]);
        }
        dispatch_semaphore_signal(weakSelf.semaphore);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
