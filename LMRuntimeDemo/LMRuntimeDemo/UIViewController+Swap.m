//
//  UIViewController+Swap.m
//  LMRuntimeDemo
//
//  Created by 黎明 on 2017/7/3.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "UIViewController+Swap.h"

@implementation UIViewController (Swap)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SwizzleMethod([self class], @selector(viewWillAppear:), @selector(lm_viewWillAppear:));
    });
}

- (void)lm_viewWillAppear:(BOOL)animated
{
    
    
    NSLog(@"%s", __FUNCTION__);
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self lm_viewWillAppear:animated];
}

@end
