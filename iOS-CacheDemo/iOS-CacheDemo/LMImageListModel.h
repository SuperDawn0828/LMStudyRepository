//
//  LMImageListModel.h
//  iOS-CacheDemo
//
//  Created by 黎明 on 2017/8/3.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LMImagePageModel;

@interface LMImageListModel : NSObject

@property (nonatomic, assign) NSInteger ret_code;

@property (nonatomic, strong) LMImagePageModel *pagebean;

@end

@interface LMImagePageModel : NSObject

@property (nonatomic, strong) NSArray *contentlist;

@property (nonatomic, assign) NSInteger maxResult;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) NSInteger allNum;

@property (nonatomic, assign) NSInteger allPages;

@end

@interface LMImageContentMolde : NSObject

@property (nonatomic, strong) NSString *typeName;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSArray *list;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSString *itemId;

@property (nonatomic, strong) NSString *ct;

@end

@interface LMImageModel : NSObject

@property (nonatomic, strong) NSString *big;

@property (nonatomic, strong) NSString *samll;

@property (nonatomic, strong) NSString *middle;

@end
