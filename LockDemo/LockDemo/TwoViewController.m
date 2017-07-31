//
//  TwoViewController.m
//  LockDemo
//
//  Created by 黎明 on 2017/7/24.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@property (nonatomic, strong) NSLock *lock;

@property (nonatomic, strong) NSRecursiveLock *recursiveLock;

@property (nonatomic, strong) dispatch_queue_t queue;

@property (nonatomic, copy) void(^lockBlock)(void);

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lock = [[NSLock alloc] init];
    
    self.recursiveLock = [[NSRecursiveLock alloc] init];
    
    self.queue = dispatch_queue_create("com.lockdemo.recursivelock", DISPATCH_QUEUE_SERIAL);
    
}

//如出现死锁，可使用递归锁解决
- (IBAction)buttonOneAction:(UIButton *)sender {
    __block int index = 0;
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.queue, ^{
        weakSelf.lockBlock = ^{
            NSLog(@"lock index: %d", index);
            [weakSelf.recursiveLock lock];
            [NSThread sleepForTimeInterval:1];
            NSLog(@"lock index: %d current thread: %@", index, [NSThread currentThread]);
            index ++;
            if (index < 10) {
                weakSelf.lockBlock();
            }
            [NSThread sleepForTimeInterval:2];
            [weakSelf.recursiveLock unlock];
            NSLog(@"lock unlock");
        };
        weakSelf.lockBlock();
    });
}

//死锁产生原因：在没有解锁的前提下，同一线程重复加锁。
- (IBAction)buttonTwoAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.queue, ^{
        weakSelf.lockBlock = ^{
            NSLog(@"lock");
            [weakSelf.lock lock];
            [NSThread sleepForTimeInterval:1];
            NSLog(@"lock current thread: %@", [NSThread currentThread]);
            weakSelf.lockBlock();
            [NSThread sleepForTimeInterval:2];
            [weakSelf.lock unlock];
            NSLog(@"lock unlock");
        };
        weakSelf.lockBlock();
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
