//
//  LMImageTableViewCell.m
//  iOS-CacheDemo
//
//  Created by 黎明 on 2017/8/4.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "LMImageTableViewCell.h"

@interface LMImageTableViewCell ()

@property (nonatomic, strong) UIImageView *fullImageView;

@end

@implementation LMImageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = width * 2.0 / 3.0;
    
    self.fullImageView = [[UIImageView alloc] init];
    self.fullImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.fullImageView.frame = CGRectMake(0, 0, width, height);
    self.fullImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.fullImageView];
}

@end
