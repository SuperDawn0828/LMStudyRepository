//
//  LMImageCacheFile.m
//  iOS-CacheDemo
//
//  Created by 黎明 on 2017/8/5.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "LMImageCacheFile.h"

@implementation LMImageCacheFile

+ (NSString *)imageCacheDirectoryPath
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *imageCachePath = [cachePath stringByAppendingPathComponent:@"LMImageCache"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [fileManager fileExistsAtPath:imageCachePath isDirectory:&isDirectory];
    if (isDirectory && isExist) {
        return imageCachePath;
    }
    
    NSError *error;
    BOOL isCreate = [fileManager createDirectoryAtPath:imageCachePath withIntermediateDirectories:YES attributes:nil error:&error];
    if (error == nil && isCreate) {
        return imageCachePath;
    }

    return nil;
}

+ (NSString *)imageCacheFilePath:(NSString *)fileName
{
    NSString *imageCachePath = [self imageCacheDirectoryPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [fileManager fileExistsAtPath:imageCachePath isDirectory:&isDirectory];
    if (isDirectory && isExist) {
        NSString *imagePath = [imageCachePath stringByAppendingPathComponent:fileName];
        return imagePath;
    }
    return nil;
}

+ (BOOL)imageFileIsExist:(NSString *)imagePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [fileManager fileExistsAtPath:imagePath isDirectory:&isDirectory];
    if (isExist && !isDirectory) {
        return YES;
    }
    return NO;
}

+ (BOOL)writeImageData:(NSData *)data atPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager createFileAtPath:path contents:data attributes:nil];
    return result;
}

+ (NSData *)readImagePath:(NSString *)imagePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *data = [fileManager contentsAtPath:imagePath];
    return data;
}

@end
