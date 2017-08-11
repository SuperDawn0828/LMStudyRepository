//
//  LMImageCache.m
//  iOS-CacheDemo
//
//  Created by 黎明 on 2017/8/3.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "LMImageCache.h"
#import "LMImageCacheFile.h"
#import "LMImageCacheConfig.h"

@interface LMImageCache ()

@property (nonatomic, strong) dispatch_queue_t imageCacheQueue;

@property (nonatomic, strong) NSMutableDictionary *imageCacheDictionary;

@end

@implementation LMImageCache

+ (instancetype)shareInstance
{
    static LMImageCache *imageCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageCache = [[LMImageCache alloc] init];
    });
    
    return imageCache;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageCacheQueue = dispatch_queue_create("com.imageCache.queue", DISPATCH_QUEUE_CONCURRENT);
        self.imageCacheDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return self;
}

- (LMImageOperation *)webImageWithURL:(NSURL *)url completionImage:(void(^)(UIImage * image))completionImage
{
    __weak typeof(self) weakSelf = self;
    LMImageOperation *imageOperation = [LMImageOperation imageOperationWithURL:url completionImage:^(UIImage *image, NSData *data) {
        if (image) {
            NSString *key = [LMImageCacheConfig md5HexDigest:url.absoluteString];
            NSString *filePath = [LMImageCacheFile imageCacheFilePath:key];
            [LMImageCacheFile writeImageData:data atPath:filePath];
            [weakSelf.imageCacheDictionary setObject:image forKey:key];
        }
        [weakSelf image:image completionImage:completionImage];
    }];
    [imageOperation start];
    return imageOperation;
}

- (BOOL)imageFromUserDisk:(NSString *)imagePath completionImage:(void(^)(UIImage * image))completionImage
{
    NSString *key = [LMImageCacheConfig md5HexDigest:imagePath];
    NSString *path = [LMImageCacheFile imageCacheFilePath:key];
    if ([LMImageCacheFile imageFileIsExist:path]) {
        __weak typeof(self) weakSelf = self;
        dispatch_async(self.imageCacheQueue, ^{
            NSData *data = [LMImageCacheFile readImagePath:path];
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                [weakSelf.imageCacheDictionary setObject:image forKey:key];
            }
            [weakSelf image:image completionImage:completionImage];
        });
        return YES;
    }
    return NO;
}

- (UIImage *)imageFromRAM:(NSString *)imagePath
{
    NSString *key = [LMImageCacheConfig md5HexDigest:imagePath];
    UIImage *image = self.imageCacheDictionary[key];
    return image;
}

- (void)removeImageCacheFromRAM:(NSArray *)array
{
    for (NSString *url in array) {
        NSString *key = [LMImageCacheConfig md5HexDigest:url];
        [self.imageCacheDictionary removeObjectForKey:key];
    }
}

- (void)image:(UIImage *)image completionImage:(void(^)(UIImage * image))completionImage
{
    dispatch_async(dispatch_get_main_queue(), ^{
        completionImage(image);
    });
}



@end
