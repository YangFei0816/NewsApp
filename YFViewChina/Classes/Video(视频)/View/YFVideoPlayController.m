//
//  YFVideoPlayController.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/24.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "YFVideoPlayController.h"

@interface YFVideoPlayController ()
{
    BOOL _isPlay;
    NSDateFormatter *_dateFormatter;
    NSString *_totalTime;
    NSString *_currentSecond;

}
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIButton *statusBtn;
@property (nonatomic, strong) UIImageView *pauseImageView;
@property (nonatomic, strong) UIProgressView *videoProgress;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation YFVideoPlayController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isPlay = YES;
    self.view.backgroundColor = [UIColor blackColor];
    //添加左侧返回按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"night_icon_back"] style:0 target:self action:@selector(backToHome)];
    self.navigationItem.leftBarButtonItem = item;
    
    self.statusBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.statusBtn.backgroundColor = [UIColor grayColor];
    self.statusBtn.frame = CGRectMake(20, 320, 50, 50);
    self.statusBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.statusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.statusBtn setTitle:@"stop" forState:UIControlStateNormal];
    [self.statusBtn addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.statusBtn];
  
    //创建暂停的时候中间显示的图标
    self.pauseImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play120"]];
    self.pauseImageView.frame = CGRectMake(150, 140, 70, 70);
}


- (void)changeStatus:(UIButton *)statusBtn {
    if (!_isPlay) {
        [self.player play];
        [self.pauseImageView removeFromSuperview];
        [self.statusBtn setTitle:@"stop" forState:UIControlStateNormal];
    } else {
        [self.player pause];
        [self.view addSubview:self.pauseImageView];
        [self.statusBtn setTitle:@"play" forState:UIControlStateNormal];
    }
    _isPlay = !_isPlay;
}
- (void)backToHome {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (YFVideoPlayController *)initWithUrlString:(NSString *)urlString {
    if (self = [super init]) {
        NSURL *movieUrl = [NSURL URLWithString:urlString];
        AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:movieUrl options:nil];
        self.playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
        [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.frame = CGRectMake(0, 44, 375, 300);
        [self.view addSubview:self.activityView];
        [self.view.layer addSublayer:self.playerLayer];
        //视频播放结束通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    }
    return self;
}
+ (YFVideoPlayController  *)videoViewWithUrlString:(NSString *)urlString {
    return [[self alloc] initWithUrlString:urlString];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    __weak typeof(self) weakSelf = self;
    if ([keyPath isEqualToString:@"status"]) {
        if ([self.playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"已经准备好播放-->>");
            //视频总长度
            CGFloat totalTime = self.playerItem.duration.value/weakSelf.playerItem.duration.timescale;
            _totalTime = [weakSelf convertTime:totalTime];
            //监听播放状态
            [weakSelf.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
                //创建显示时间进度的Label
                weakSelf.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(260, 350, 110, 25)];
                weakSelf.timeLabel.backgroundColor = [UIColor whiteColor];
                [weakSelf.view addSubview:weakSelf.timeLabel];
                //当前在第几秒
                CGFloat currentTime = weakSelf.playerItem.currentTime.value/weakSelf.playerItem.currentTime.timescale;
                _currentSecond = [weakSelf convertTime:currentTime];
                weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@/%@",_currentSecond,_totalTime];
            }];
            [self.activityView stopAnimating];
            [self.player play];
        }
    }
}
- (UIActivityIndicatorView *)activityView {
    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(180, 140, 0, 0)];
        _activityView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        [_activityView startAnimating];
        [self.activityView hidesWhenStopped];
    }
    return _activityView;
}
- (void)videoPlayDidEnd:(AVPlayerItem *)playerItem {
    NSLog(@"播放已经结束-->>");
    [self.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        //播放结束把videoView从视图上移除
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
- (void)dealloc {
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
//    [self.player.currentItem cancelPendingSeeks];
//    [self.player.currentItem.asset cancelLoading];

}
- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [[self dateFormatter] stringFromDate:d];
    return showtimeNew;
}
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}
- (void)viewDidDisappear:(BOOL)animated {
    self.player = nil;
    self.playerItem = nil;
    self.playerLayer = nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
