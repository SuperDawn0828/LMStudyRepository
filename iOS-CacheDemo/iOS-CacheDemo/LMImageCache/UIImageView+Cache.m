//
//  UIImageView+Cache.m
//  iOS-CacheDemo
//
//  Created by 黎明 on 2017/8/4.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "UIImageView+Cache.h"
#import "LMImageCache.h"
#import "LMImageCacheConfig.h"

@implementation UIImageView (Cache)

- (void)imageCacheWithURL:(NSURL *)url
{
    self.image = nil;
    
    UIImage *image = [[LMImageCache shareInstance] imageFromRAM:url.absoluteString];
    if (image) {
        self.image = image;
        return;
    }
    
    __block NSMutableArray *imageKeyArray = [self imageCacheDictionary];
    __weak typeof(self) weakSelf = self;
    BOOL result = [[LMImageCache shareInstance] imageFromUserDisk:url.absoluteString completionImage:^(UIImage *image) {
        [imageKeyArray addObject:url.absoluteString];
        weakSelf.image = image;
    }];
    
    if (result) {
        return;
    }
    
    LMImageOperation *operation = [self imageViewOperation];
    if (operation && [operation isKindOfClass:[LMImageOperation class]]) {
        [operation cancel];
    }
    
    
    operation = [[LMImageCache shareInstance] webImageWithURL:url
                                              completionImage:^(UIImage *image) {
                                                  [imageKeyArray addObject:url.absoluteString];
                                                  weakSelf.image = image;
                                              }];
    [self setImageViewOperation:operation];
}

static NSString * const ImageViewOperationKey = @"ImageViewOperationKey";
static NSString * const ImageCacheArrayKey = @"ImageCacheArrayKey";

- (void)setImageViewOperation:(LMImageOperation *)operation
{
    objc_setAssociatedObject(self, &ImageViewOperationKey, operation, OBJC_ASSOCIATION_RETAIN);
}

- (LMImageOperation *)imageViewOperation
{
    return objc_getAssociatedObject(self, &ImageViewOperationKey);
}

- (NSMutableArray *)imageCacheDictionary
{
    NSMutableArray *array = objc_getAssociatedObject(self, &ImageCacheArrayKey);
    if (!array) {
        array = [NSMutableArray arrayWithCapacity:0];
        objc_setAssociatedObject(self, &ImageCacheArrayKey, array, OBJC_ASSOCIATION_RETAIN);
    }
    return array;
}

@end
