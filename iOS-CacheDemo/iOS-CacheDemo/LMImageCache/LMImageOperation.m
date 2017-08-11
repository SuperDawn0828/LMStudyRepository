//
//  LMImageOperation.m
//  iOS-CacheDemo
//
//  Created by 黎明 on 2017/8/4.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "LMImageOperation.h"

static dispatch_queue_t ImageOperationQueue() {
    static dispatch_queue_t imageOperationQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageOperationQueue = dispatch_queue_create("com.imageoperatiom.queue", DISPATCH_QUEUE_CONCURRENT);
    });
    return imageOperationQueue;
}

@interface LMImageOperation ()

@property (nonatomic, assign) BOOL isCancel;

@property (nonatomic, assign) BOOL isChange;

@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, copy) void (^completionImage)(UIImage * image, NSData *data);

@property (nonatomic, strong) NSURL *url;

@end

@implementation LMImageOperation

+ (LMImageOperation *)imageOperationWithURL:(NSURL *)url completionImage:(void(^)(UIImage * image, NSData *data))completionImage;
{
    LMImageOperation *imageOperation = [[LMImageOperation alloc] init];
    imageOperation.url = url;
    imageOperation.completionImage = completionImage;
    imageOperation.isCancel = NO;
    imageOperation.isChange = NO;
    
    return imageOperation;
}

- (void)start
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(ImageOperationQueue(), ^{
        weakSelf.session = [NSURLSession sharedSession];
        NSURLRequest *request = [NSURLRequest requestWithURL:weakSelf.url];
        NSURLSessionDataTask *dataTask = [weakSelf.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            UIImage *image = nil;
            if (!error) {
                NSInteger code = [(NSHTTPURLResponse *)response statusCode];
                if (code == 200) {
                    if (data) {
                        image = [UIImage imageWithData:data];
                    }
                }
            }
            if (weakSelf.completionImage) {
                weakSelf.completionImage(image, data);
            }
            weakSelf.isChange = YES;
        }];
        [dataTask resume];
    });
}

- (void)cancel
{
    if (self.isChange) {
        return;
    }
    
    [self.session invalidateAndCancel];
    self.isCancel = YES;
    self.completionImage = nil;
}

- (void)dealloc
{

}

@end
