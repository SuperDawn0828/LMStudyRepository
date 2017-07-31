//
//  OneViewController.m
//  LockDemo
//
//  Created by 黎明 on 2017/7/24.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()

@property (nonatomic, strong) NSLock *lock;

@end

@implementation OneViewController

- (NSLock *)lock
{
    if (!_lock) {
        _lock = [[NSLock alloc] init];
    }
    return _lock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)buttonOneAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_queue_create("com.lockdemo.nslock.one", DISPATCH_QUEUE_CONCURRENT), ^{
        [weakSelf.lock lock];
        for (NSInteger index = 0; index < 10; index ++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"one action index: %ld, current thread: %@", index, [NSThread currentThread]);
        }
        [weakSelf.lock unlock];
    });
}

- (IBAction)buttonTwoAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_queue_create("com.lockdemo.nslock.two", DISPATCH_QUEUE_CONCURRENT), ^{
        [weakSelf.lock lock];
        for (NSInteger index = 0; index < 10; index ++) {
            [NSThread sleepForTimeInterval:1];
            NSLog(@"two action index: %ld, current thread: %@", index, [NSThread currentThread]);
        }
        [weakSelf.lock unlock];
    });
}

- (IBAction)buttonThreeAction:(UIButton *)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (self) {
            sleep(3);
            NSLog(@"button action 3, current thread: %@", [NSThread currentThread]);
        }
    });
}

- (IBAction)buttonFourAction:(UIButton *)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (self) {
            NSLog(@"button action 4, current thread: %@", [NSThread currentThread]);
        }
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
