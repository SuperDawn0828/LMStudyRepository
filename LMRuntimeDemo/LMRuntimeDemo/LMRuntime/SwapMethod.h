//
//  SwapMethod.h
//  LMRuntimeDemo
//
//  Created by 黎明 on 2017/7/3.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void SwizzleMethod(Class cls, SEL originalSelector, SEL swapSelector);
