//
//  SwapMethod.m
//  LMRuntimeDemo
//
//  Created by 黎明 on 2017/7/3.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "SwapMethod.h"
#import <objc/runtime.h>

void SwizzleMethod(Class cls, SEL originSelector, SEL swapSelector)
{
    Method originMethod = class_getInstanceMethod(cls, originSelector);
    Method swapMethod = class_getInstanceMethod(cls, swapSelector);
    
    BOOL didAddMethod = class_addMethod(cls,
                                        originSelector,
                                        class_getMethodImplementation(cls, swapSelector),
                                        method_getTypeEncoding(swapMethod));
    if (didAddMethod) {
        class_replaceMethod(cls,
                            swapSelector,
                            method_getImplementation(originMethod),
                            method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swapMethod);
    }
}
