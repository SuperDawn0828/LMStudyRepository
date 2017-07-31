//
//  FourViewController.m
//  LockDemo
//
//  Created by 黎明 on 2017/7/24.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()

@property (nonatomic, strong) NSConditionLock *conditionLock;

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.conditionLock = [[NSConditionLock alloc] initWithCondition:0];
    
}

- (IBAction)buttonOneAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
//    GlobalQueue(^{
//        for (NSInteger index = 0; index < 3; index ++) {
//            [weakSelf.conditionLock lock];
//            NSLog(@"index: 0.%ld", index);
//            sleep(1);
//            [weakSelf.conditionLock unlock];
//        }
//    });
//    
    sleep(1);
    
    GlobalQueue(^{
        [weakSelf.conditionLock lock];
        NSLog(@"index 1");
        [weakSelf.conditionLock unlock];
    });
    
    GlobalQueue(^{
        [weakSelf.conditionLock lockWhenCondition:2];
        NSLog(@"index 2");
        [weakSelf.conditionLock unlockWithCondition:0];
    });
    
    GlobalQueue(^{
        [weakSelf.conditionLock lockWhenCondition:1];
        NSLog(@"index 3");
        [weakSelf.conditionLock unlockWithCondition:2];
    });
    
    GlobalQueue(^{
        [weakSelf.conditionLock lockWhenCondition:0];
        NSLog(@"index 4");
        [weakSelf.conditionLock unlockWithCondition:1];
    });
}

void GlobalQueue(dispatch_block_t block) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
