//
//  LMImageOperation.h
//  iOS-CacheDemo
//
//  Created by 黎明 on 2017/8/4.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMImageOperation : NSObject

+ (LMImageOperation *)imageOperationWithURL:(NSURL *)url completionImage:(void(^)(UIImage * image, NSData *data))completionImage;

- (void)start;

- (void)cancel;

@end
