//
//  LMCommand.h
//  iOS-CacheDemo
//
//  Created by 黎明 on 2017/8/3.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionHandler)(id _Nullable object, NSError * _Nullable error);

@interface LMCommand : NSObject

+ (void)imageType:(CompletionHandler _Nullable )completionHandler;

+ (void)searchImage:(NSInteger)type page:(NSInteger)page completionHandler:(CompletionHandler _Nullable )completionHandler;

@end
