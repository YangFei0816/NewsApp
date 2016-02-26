//
//  YFVideoPlayController.h
//  YFViewChina
//
//  Created by qianfneg on 16/1/24.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface YFVideoPlayController : UIViewController
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
- (YFVideoPlayController *)initWithUrlString:(NSString *)urlString;
+ (YFVideoPlayController *)videoViewWithUrlString:(NSString *)urlString;
@end
