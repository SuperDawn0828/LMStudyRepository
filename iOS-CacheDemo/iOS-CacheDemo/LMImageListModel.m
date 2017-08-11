//
//  LMImageListModel.m
//  iOS-CacheDemo
//
//  Created by 黎明 on 2017/8/3.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "LMImageListModel.h"

@implementation LMImageListModel

@end

@implementation LMImagePageModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"contentlist": @"LMImageContentMolde"};
}

@end

@implementation LMImageContentMolde

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"list": @"LMImageModel"};
}

@end

@implementation LMImageModel

@end
