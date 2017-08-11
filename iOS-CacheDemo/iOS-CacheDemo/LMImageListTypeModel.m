//
//  LMImageListTypeModel.m
//  iOS-CacheDemo
//
//  Created by 黎明 on 2017/8/3.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "LMImageListTypeModel.h"

@implementation LMImageListTypeModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"list": @"LMImageTypeModel"};
}

@end

@implementation LMImageTypeModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"list": @"LMImageCodeModel"};
}

@end

@implementation LMImageCodeModel


@end
