//
//  LMPlayerManager.h
//  LMAVPlayerDemo
//
//  Created by 黎明 on 2017/8/22.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LMPlayerManager;

@protocol LMPlayerManagerDelegate <NSObject>

@optional
- (void)playerManager:(LMPlayerManager *)manager totalDuration:(NSTimeInterval)duration;

- (void)playerManager:(LMPlayerManager *)manager availableDuration:(NSTimeInterval)duration;

- (void)playerManager:(LMPlayerManager *)manager playerProgress:(double)progress;

- (void)playerManagerDidPlayFinish:(LMPlayerManager *)manager;

- (void)playerManagerPlayerFailed:(LMPlayerManager *)manager;

@end

@interface LMPlayerManager : NSObject

@property (nonatomic, weak) id<LMPlayerManagerDelegate> delegate;

+ (instancetype)manager;

- (void)loadPlayerWithView:(UIView *)view;

- (void)loadVideoFromURL:(NSURL *)URL;

- (void)play;

- (void)pause;

- (void)stop;

@end
