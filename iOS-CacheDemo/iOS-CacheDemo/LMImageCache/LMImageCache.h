//
//  LMImageCache.h
//  iOS-CacheDemo
//
//  Created by 黎明 on 2017/8/3.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMImageOperation.h"

@interface LMImageCache : NSObject

+ (instancetype)shareInstance;

- (void)image:(UIImage *)image completionImage:(void(^)(UIImage * image))completionImage;

- (LMImageOperation *)webImageWithURL:(NSURL *)url completionImage:(void(^)(UIImage * image))completionImage;

- (BOOL)imageFromUserDisk:(NSString *)imagePath completionImage:(void(^)(UIImage * image))completionImage;

- (UIImage *)imageFromRAM:(NSString *)imagePath;

- (void)removeImageCacheFromRAM:(NSArray *)array;

@end
