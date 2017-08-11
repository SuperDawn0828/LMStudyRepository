//
//  LMImageListTypeModel.h
//  iOS-CacheDemo
//
//  Created by 黎明 on 2017/8/3.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMImageListTypeModel : NSObject

@property (nonatomic, assign) NSInteger ret_code;

@property (nonatomic, strong) NSArray *list;

@end

@interface LMImageTypeModel : NSObject

@property (nonatomic, strong) NSArray *list;

@property (nonatomic, strong) NSString *name;

@end

@interface LMImageCodeModel : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, strong) NSString *name;

@end
