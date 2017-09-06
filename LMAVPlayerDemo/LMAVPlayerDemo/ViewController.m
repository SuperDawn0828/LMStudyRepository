//
//  ViewController.m
//  LMAVPlayerDemo
//
//  Created by 黎明 on 2017/8/22.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "ViewController.h"
#import "LMPlayerManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *playerView;

@property (nonatomic, strong) LMPlayerManager *playerManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.playerManager = [LMPlayerManager manager];
    [self.playerManager loadPlayerWithView:self.playerView];
    [self.playerManager loadVideoFromURL:[NSURL URLWithString:@"http://download.3g.joy.cn/video/236/60236937/1451280942752_hd.mp4"]];
    
}

- (IBAction)playAction:(UIButton *)sender {
    [self.playerManager play];
}

- (IBAction)pauseAction:(UIButton *)sender {
    [self.playerManager pause];
}

- (IBAction)stopAction:(UIButton *)sender {
    [self.playerManager stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
