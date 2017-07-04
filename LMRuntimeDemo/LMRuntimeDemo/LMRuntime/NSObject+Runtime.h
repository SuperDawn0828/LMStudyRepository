//
//  NSObject+Runtime.h
//  LMRuntimeDemo
//
//  Created by 黎明 on 2017/7/3.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)

+ (NSArray *)fetchIvarList;

+ (NSArray *)fetchPropertyList;

+ (NSArray *)fetchInstanceMethodList;

+ (NSArray *)fetchClassMetchodList;

+ (NSArray *)fetchProtocolList;

+ (void)addMethod:(SEL)methodSel methodImp:(SEL)methodImp;

+ (void)swapMethod:(SEL)originMethod currentMethod:(SEL)currentMethod;

+ (void)swapClassMethod:(SEL)originMethod currentMethod:(SEL)currentMethod;

@end
