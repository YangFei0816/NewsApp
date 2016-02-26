//
//  YFTableViewController.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/18.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "YFTableViewController.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "YFNetworkTool.h"
#import "YFNewsCell.h"
#import "YFNewsModel.h"
#import "YFDetailViewController.h"

@interface YFTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL isUpdate;
@property (nonatomic, assign) int currentPage;
@end

@implementation YFTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据源数组
    self.dataSource = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefresh)];
    self.tableView.headerPullToRefreshText = @"继续下拉开始刷新";
    self.tableView.headerReleaseToRefreshText = @"松开开始刷新";
    self.tableView.headerRefreshingText = @"正在刷新中...";
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRefresh)];
    self.tableView.footerPullToRefreshText = @"继续下拉开始加载数据";
    self.tableView.footerReleaseToRefreshText = @"松开开始加载数据";
    self.tableView.footerRefreshingText = @"正在载入中...";
//    [self.tableView headerBeginRefreshing];
    [self.tableView headerBeginRefreshing];
 
}
- (void)viewWillAppear:(BOOL)animated {
    
    
}
//获取数据
- (void)getData {
    //拼接路径
    NSString *wholeUrl = [NSString stringWithFormat:@"%@/%d-20.html",self.urlString, _currentPage];
    [[[YFNetworkTool sharedNetworkTool] GET:wholeUrl parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        //获取每一个返回的大字典的唯一大key
        NSString *key = [responseObject.keyEnumerator nextObject];
        //通过key取出每个字典中的 数据 是个array
        if ([key isEqualToString:@"city"]) {
            key = @"list";
        }
        NSArray *dataArray = responseObject[key];
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSDictionary *dict in dataArray) {
            YFNewsModel *model = [YFNewsModel newsModelWithDict:dict];
            [mArray addObject:model];
        }
            [self.dataSource addObjectsFromArray:mArray];
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
            [self.tableView footerEndRefreshing];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"请求失败! error:%@",error);
    }] resume];
    
}
// 上拉刷新
- (void)headerRefresh {
    _currentPage = 0;
    [self.dataSource removeAllObjects];
    [self performSelector:@selector(getData) withObject:nil afterDelay:0.5];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.tableView reloadData];
//        [self.tableView headerEndRefreshing];
//    });
}
// 下拉加载
- (void)footerRefresh {
    _currentPage += 20;
    [self performSelector:@selector(getData) withObject:nil afterDelay:0.5];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.tableView reloadData];
//        [self.tableView footerEndRefreshing];
//        
//    });
}
#pragma mark - tabView 代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    YFNewsModel *model = nil;
//    if (indexPath.row < self.dataSource.count) {
//        model = self.dataSource[indexPath.row];
//    }
#pragma mark - 给NSArray添加类别 防止数组越界
    
    YFNewsModel *model = [self.dataSource objectAtIndexCheck:indexPath.row];
     NSString * ID = [YFNewsCell IDWithModel:model];
    YFNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    YFNewsModel *model = nil;
//    if (indexPath.row < self.dataSource.count) {
//        model = self.dataSource[indexPath.row];
//    }
#pragma mark - 给NSArray添加类别 防止数组越界
    
    YFNewsModel *model = [self.dataSource objectAtIndexCheck:indexPath.row];
    if (model.imgextra.count) {
        return 130;
    } else if(model.imgType) {
        return 170;
    } else {
        return 90;
    }
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.destinationViewController isKindOfClass:[YFDetailViewController class]]) {
        NSIndexPath *indexPath  = self.tableView.indexPathForSelectedRow;
        YFNewsModel *model = self.dataSource[indexPath.row];
         YFDetailViewController *detailVC = segue.destinationViewController;
        if (model.photosetID.length) {
            detailVC.urlStr = model.threePicUrl;
        
        } else {
            detailVC.urlStr = model.url_3w;
        }
    }
}
@end
