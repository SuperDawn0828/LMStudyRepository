//
//  ViewController.m
//  LMRuntimeDemo
//
//  Created by 黎明 on 2017/7/3.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "ViewController.h"
#import "TestClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TestClass *test = [[TestClass alloc] init];
    [test publicInstanceMethod];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)vcPublicInstanceMethod
{
    NSLog(@"%s", __FUNCTION__);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
