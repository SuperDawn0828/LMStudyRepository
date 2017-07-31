//
//  FiveViewController.m
//  LockDemo
//
//  Created by 黎明 on 2017/7/24.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "FiveViewController.h"

@interface FiveViewController ()

@property (nonatomic, strong) dispatch_queue_t lockQueue;

@property (nonatomic, strong) NSString *string;

@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lockQueue = dispatch_queue_create("com.lockdemo.readwrite.lock", DISPATCH_QUEUE_SERIAL);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonOneAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    dispatch_barrier_async(self.lockQueue, ^{
        sleep(5);
        weakSelf.string = @"123456";
        NSLog(@"current thread: %@", [NSThread currentThread]);
    });
}

- (IBAction)buttonTwoAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.lockQueue, ^{
        NSLog(@"string: %@, current thread: %@", weakSelf.string, [NSThread currentThread]);
    });
}

- (IBAction)buttonFourAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.lockQueue, ^{
        NSLog(@"string: %@, current thread: %@", weakSelf.string, [NSThread currentThread]);
    });
}

- (IBAction)buttonThreeAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    dispatch_async(self.lockQueue, ^{
        NSLog(@"string: %@, current thread: %@", weakSelf.string, [NSThread currentThread]);
    });
}

@end
