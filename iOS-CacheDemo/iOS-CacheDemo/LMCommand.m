//
//  LMCommand.m
//  iOS-CacheDemo
//
//  Created by 黎明 on 2017/8/3.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "LMCommand.h"

@implementation LMCommand

static NSString * const apiKey = @"0b0a47ae0e25284a3078d1c081f0b1a1";

static NSString * const imageTypeUrl = @"http://apis.baidu.com/showapi_open_bus/pic/pic_type";

static NSString * const searchImageUrl = @"http://apis.baidu.com/showapi_open_bus/pic/pic_search";

+ (void)imageType:(CompletionHandler)completionHandler
{
    [self commandRquest:imageTypeUrl httpArg:nil completionHandler:completionHandler];
}

+ (void)searchImage:(NSInteger)type page:(NSInteger)page completionHandler:(CompletionHandler)completionHandler
{
    NSString *httpArg = [NSString stringWithFormat:@"type=%ld&page=%ld", type, page];
    [self commandRquest:searchImageUrl httpArg:httpArg completionHandler:completionHandler];
}

+ (void)commandRquest:(NSString *)httpUrl httpArg:(NSString *)httpArg completionHandler:(CompletionHandler)completionHandler
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *urlStr = [NSString stringWithFormat:@"%@?%@", httpUrl, httpArg];
        NSURL *url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"GET"];
        [request addValue:apiKey forHTTPHeaderField:@"apikey"];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTase = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                            if (error != nil) {
                                                [LMCommand reponseData:nil error:error completionHandler:completionHandler];
                                            } else {
                                                NSInteger code = [(NSHTTPURLResponse *)response statusCode];
                                                
                                                NSError *error;
                                                id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                                
                                                if (error != nil) {
                                                    [LMCommand reponseData:nil error:error completionHandler:completionHandler];
                                                } else {
                                                    
                                                    if ([object isKindOfClass:[NSDictionary class]]) {
                                                        NSDictionary *dict = (NSDictionary *)object;
                                                        id data = dict[@"showapi_res_body"];
                                                        [LMCommand reponseData:data error:nil completionHandler:completionHandler];
                                                    } else {
                                                        [LMCommand reponseData:nil error:error completionHandler:completionHandler];
                                                    }
                                                }
                                                NSLog(@"code: %ld", code);
                                                NSLog(@"responseString: %@", object);
                                            }
                                        }];
        [dataTase resume];
    });
}

+ (void)reponseData:(id)data error:(NSError *)error completionHandler:(CompletionHandler)completionHandler
{
    dispatch_async(dispatch_get_main_queue(), ^{
        completionHandler(data, error);
    });
}

@end
