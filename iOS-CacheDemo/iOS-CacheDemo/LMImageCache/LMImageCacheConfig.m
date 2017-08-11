//
//  LMImageCahceConfig.m
//  iOS-CacheDemo
//
//  Created by 黎明 on 2017/8/5.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "LMImageCacheConfig.h"
#import <CommonCrypto/CommonDigest.h>

@implementation LMImageCacheConfig

+ (NSString *)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}

@end
