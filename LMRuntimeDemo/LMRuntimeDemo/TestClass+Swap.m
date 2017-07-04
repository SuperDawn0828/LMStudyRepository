//
//  TestClass+Swap.m
//  LMRuntimeDemo
//
//  Created by 黎明 on 2017/7/3.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "TestClass+Swap.h"

@implementation TestClass (Swap)

+ (void)load
{
    SwizzleMethod([self class], @selector(publicInstanceMethod), @selector(lm_publicInstanceMethod));
}

- (void)lm_publicInstanceMethod
{
    NSLog(@"%s", __FUNCTION__);
}

@end
