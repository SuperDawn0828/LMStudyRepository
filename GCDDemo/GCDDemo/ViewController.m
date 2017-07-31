//
//  ViewController.m
//  GCDDemo
//
//  Created by 黎明 on 2017/7/20.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)asyncConcurrent:(UIButton *)sender {
    dispatch_queue_t queue = dispatch_queue_create("com.gcddemo.asyncconcurrent", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        for (int index = 0; index < 5; index ++) {
            NSLog(@"asyncIndex: 1-%d, currentThread: %@", index, [NSThread currentThread]);
        }
    });
    
    
    dispatch_async(queue, ^{
        for (int index = 0; index < 5; index ++) {
            NSLog(@"asyncIndex: 2-%d, currentThread: %@", index, [NSThread currentThread]);
        }
    });
}

- (IBAction)syncConcurrent:(UIButton *)sender {
    dispatch_queue_t queue = dispatch_queue_create("com.gcddemo.syncconcurrent", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
            for (int index = 0; index < 5; index ++) {
            NSLog(@"syncIndex: 1-%d, currentThread: %@", index, [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int index = 0; index < 5; index ++) {
            NSLog(@"syncIndex: 2-%d, currentThread: %@", index, [NSThread currentThread]);
        }
    });
    
}

- (IBAction)asyncSerail:(UIButton *)sender {
    dispatch_queue_t queue = dispatch_queue_create("com.gdcdemo.asyncserail", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        for (int index = 0; index < 5; index ++) {
            NSLog(@"asyncserialIndex: 1-%d, currentThread: %@", index, [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int index = 0; index < 5; index ++) {
            NSLog(@"asyncserialIndex: 2-%d, currentThread: %@", index, [NSThread currentThread]);
        }
    });
    
}

- (IBAction)syncSerail:(UIButton *)sender {
    dispatch_queue_t queue = dispatch_queue_create("com.gcddemo.syncserail", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        for (int index = 0; index < 5; index ++) {
            NSLog(@"syncserialIndex: 1-%d, currentThread: %@", index, [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int index = 0; index < 5; index ++) {
            NSLog(@"syncserialIndex: 2-%d, currentThread: %@", index, [NSThread currentThread]);
        }
    });
    
}

- (IBAction)asyncGloab:(UIButton *)sender {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int index = 0; index <= 10; index ++) {
        dispatch_async(queue, ^{
            NSLog(@"asyncGloabIndex: %d, currentThread: %@", index, [NSThread currentThread]);
        });
    }
}

- (IBAction)syncGloab:(UIButton *)sender {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int index = 0; index <= 10; index ++) {
        dispatch_sync(queue, ^{
            NSLog(@"syncgloabIndex: %d, curretThread: %@", index, [NSThread currentThread]);
        });
    }
}

- (IBAction)asyncMain:(UIButton *)sender {
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        for (int index = 0; index < 5; index ++) {
            NSLog(@"asyncMianIndex: 1-%d, currentThread: %@", index, [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int index = 0; index < 5; index ++) {
            NSLog(@"asyncMianIndex: 2-%d, currentThread: %@", index, [NSThread currentThread]);
        }
    });
   
}

- (IBAction)syncMain:(UIButton *)sender {
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        for (int index = 0; index <= 10; index ++) {
            NSLog(@"syncMainIndex: 1-%d, currentThread: %@", index, [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int index = 0; index <= 10; index ++) {
            NSLog(@"syncMainIndex: 2-%d, currentThread: %@", index, [NSThread currentThread]);
        }
    });
}

- (IBAction)barrierAction:(UIButton *)sender {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSLog(@"berrier index 1, currentThread: %@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"berrier index 2, currentThread: %@", [NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"current thread: %@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"berrier index 3, currentThread: %@", [NSThread currentThread]);
    });
}

- (IBAction)afterAction:(UIButton *)sender {
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC));
    dispatch_after(time, queue, ^{
        NSLog(@"after 3s, currentThread: %@", [NSThread currentThread]);
    });
}

- (IBAction)applyAction:(UIButton *)sender {
    dispatch_apply(10, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        NSLog(@"apply index: %zu, current thread: %@", index, [NSThread currentThread]);
    });
}

- (IBAction)onceAction:(UIButton *)sender {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"once, current thread: %@", [NSThread currentThread]);
    });
}

- (IBAction)groupAction:(UIButton *)sender {
    
    __block int a = 0, b = 0, c = 0;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"dispath-group index: 1, current thread: %@", [NSThread currentThread]);
        a = 1;
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"dispath-group index: 2, current thread: %@", [NSThread currentThread]);
        b = 3;
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"dispath-group index: 3, current thread: %@", [NSThread currentThread]);
        c = 5;
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"group-notify current thread: %@", [NSThread currentThread]);
        NSLog(@"a + b + c = %d", a + b + c);
    });
}

- (IBAction)signalAction:(UIButton *)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"signal current thread: %@", [NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"signal current thread: %@", [NSThread currentThread]);
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
