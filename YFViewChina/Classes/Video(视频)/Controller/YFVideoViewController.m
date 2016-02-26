//
//  YFVideoViewController.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/23.
//  Copyright © 2016年 杨飞. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "YFVideoViewController.h"
#import "YFVideoCell.h"
#import "YFVideoModel.h"
#import "YFAVPlayerController.h"
#define VIDEO_URL (@"http://s.budejie.com/topic/list/jingxuan/41/budejie-android-6.3.0")

@interface YFVideoViewController ()
@property (nonatomic, strong) NSMutableArray *videoArray;
@property (nonatomic,assign) float nextPage;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@end

@implementation YFVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nextPage = 0;
    //初始化数据源
    self.videoArray = [NSMutableArray array];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefresh)];
    self.tableView.headerPullToRefreshText = @"继续下拉开始刷新";
    self.tableView.headerReleaseToRefreshText = @"松开开始刷新";
    self.tableView.headerRefreshingText = @"正在刷新中...";
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRefresh)];
    self.tableView.footerPullToRefreshText = @"继续下拉开始加载数据";
    self.tableView.footerReleaseToRefreshText = @"松开开始加载数据";
    self.tableView.footerRefreshingText = @"正在载入中...";
    [self.tableView headerBeginRefreshing];
    
 
    
}
//加载数据
- (void)getData {
    //拼接urlString
    NSString *urlStr = [NSString stringWithFormat:@"%@/%.0lf-20.json",VIDEO_URL,self.nextPage];
    NSLog(@"%@",urlStr);
    [[[AFHTTPSessionManager manager] GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
        self.nextPage = [responseObject[@"info"][@"np"] integerValue];
        NSArray *dataArray = responseObject[@"list"];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict in dataArray) {
            YFVideoModel *model = [YFVideoModel modelWithDict:dict];
            [modelArray addObject:model];
        }
        [modelArray removeLastObject];
        [self.videoArray addObjectsFromArray:modelArray];
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure:%@",error);
    }] resume];
}
// 上拉刷新
- (void)headerRefresh {
    [self.videoArray removeAllObjects];
    [self getData];

}
// 下拉加载
- (void)footerRefresh {
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"videoCellID";
    YFVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.model = [self.videoArray objectAtIndexCheck:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    YFVideoCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    YFVideoModel *model = [self.videoArray objectAtIndexCheck:indexPath.row];
   
    YFAVPlayerController *avp = [[YFAVPlayerController alloc] init];
    NSURL *url = [NSURL URLWithString:model.videoUrl];
    self.playerItem = [AVPlayerItem playerItemWithURL:url];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:self.playerItem];
    avp.player = player;
    avp.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:avp animated:YES completion:nil];
    
    //监听播放结束
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AVPlayerDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];

}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
 
}

- (void)AVPlayerDidEnd:(AVPlayerItem *)playerItem {
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AVPlayerDidEnd" object:self.playerItem];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
