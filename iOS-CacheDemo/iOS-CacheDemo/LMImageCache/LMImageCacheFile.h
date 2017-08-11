//
//  LMImageCacheFile.h
//  iOS-CacheDemo
//
//  Created by 黎明 on 2017/8/5.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMImageCacheFile : NSObject

+ (NSString *)imageCacheDirectoryPath;

+ (NSString *)imageCacheFilePath:(NSString *)fileName;

+ (BOOL)imageFileIsExist:(NSString *)imagePath;

+ (BOOL)writeImageData:(NSData *)data atPath:(NSString *)path;

+ (NSData *)readImagePath:(NSString *)imagePath;

@end
