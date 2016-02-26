//
//  YFTitleLabel.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/18.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "YFTitleLabel.h"


@implementation YFTitleLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:19];
        self.scale = 0.0;
    }
    return self;
}
- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    self.textColor = [UIColor colorWithRed:scale green:0.2 blue:0.2 alpha:1.0];
    CGFloat minScale = 0.7;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}
@end
