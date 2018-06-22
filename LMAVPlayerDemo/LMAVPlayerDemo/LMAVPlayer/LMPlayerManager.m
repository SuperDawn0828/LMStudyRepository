//
//  LMPlayerManager.m
//  LMAVPlayerDemo
//
//  Created by 黎明 on 2017/8/22.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "LMPlayerManager.h"
#import <AVFoundation/AVFoundation.h>

@interface LMPlayerManager ()

@property (nonatomic, strong) id playTimeObserver;

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@property (nonatomic, strong) AVPlayerItem *playerItem;

@end

@implementation LMPlayerManager

- (AVPlayer *)player
{
    if (!_player) {
        _player = [[AVPlayer alloc] init];
    }
    return _player;
}

- (AVPlayerLayer *)playerLayer
{
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    }
    return _playerLayer;
}

+ (instancetype)manager
{
    return [[LMPlayerManager alloc] init];
}

- (void)dealloc
{
    [self stop];
}

- (void)loadPlayerWithView:(UIView *)view
{
    self.playerLayer.bounds = view.bounds;
    self.playerLayer.position = view.center;
    [view.layer addSublayer:self.playerLayer];
}

- (void)loadVideoFromURL:(NSURL *)URL
{
    self.playerItem = [[AVPlayerItem alloc] initWithURL:URL];
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    [self.playerLayer displayIfNeeded];
    
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerDidFinish:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    __weak typeof(self) weakSelf = self;
    self.playTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1.0)
                                                                      queue:dispatch_get_main_queue()
                                                                 usingBlock:^(CMTime time) {
                                                                     __strong typeof(self) strongSelf = weakSelf;
                                                                     double currentPlayTime = (double)strongSelf.playerItem.currentTime.value / (double)strongSelf.playerItem.currentTime.timescale;
                                                                     if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(playerManager:playerProgress:)]) {
                                                                         [strongSelf.delegate playerManager:strongSelf playerProgress:currentPlayTime];
                                                                     }
                                                                 }];
}

- (void)play
{
    [self.player play];
}

- (void)pause
{
    [self.player pause];
}

- (void)stop
{
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.playerItem = nil;
    [self.player replaceCurrentItemWithPlayerItem:nil];
    [self.player removeTimeObserver:self.playTimeObserver];
}

- (void)playerDidFinish:(NSNotification *)notification
{
    [self stop];
    if (self.delegate && [self.delegate respondsToSelector:@selector(playerManagerDidPlayFinish:)]) {
        [self.delegate playerManagerDidPlayFinish:self];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = self.playerItem.status;
        if (status == AVPlayerItemStatusReadyToPlay) {
            CMTime duration = self.playerItem.duration;
            NSTimeInterval timeInterval = CMTimeGetSeconds(duration);
            if (self.delegate && [self.delegate respondsToSelector:@selector(playerManager:totalDuration:)]) {
                [self.delegate playerManager:self totalDuration:timeInterval];
            }
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(playerManagerPlayerFailed:)]) {
                [self.delegate playerManagerPlayerFailed:self];
            }
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSArray *loadedTimeRanges = [self.playerItem loadedTimeRanges];
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];
        double startSeconds = CMTimeGetSeconds(timeRange.start);
        double durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval timeInterval = startSeconds + durationSeconds;
        if (self.delegate && [self.delegate respondsToSelector:@selector(playerManager:availableDuration:)]) {
            [self.delegate playerManager:self availableDuration:timeInterval];
        }
    }
}

@end
