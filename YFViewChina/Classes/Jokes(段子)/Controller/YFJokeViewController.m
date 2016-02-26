//
//  YFJokeViewController.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/21.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "YFJokeViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "YFJokeModel.h"
#import "YFJokeCell.h"

#define URL_JOKES  (@"http://pengfu.junpinzhi.cn/mobileClientV21.ashx?client=android&version=14&key=112&PageIndex=")
@interface YFJokeViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger currentPage;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentCT;

@end

@implementation YFJokeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.segmentCT setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [self.segmentCT addTarget:self action:@selector(changeDataSource:) forControlEvents:UIControlEventValueChanged];
    //消除cell之间的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone; 
    
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
    self.tableView.estimatedRowHeight = 44;
    _currentPage = 1;
}
//加载数据
- (void)getData {
    //拼接urlString
    NSString *urlString = [NSString stringWithFormat:@"%@%ld",URL_JOKES,_currentPage];
    [[[AFHTTPSessionManager manager] GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
        NSArray *dataArray = responseObject[@"body"][@"items"];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict in dataArray) {
            YFJokeModel *model = [YFJokeModel modelWithDict:dict];
            [modelArray addObject:model];
        }
            [self.dataSource addObjectsFromArray:modelArray];
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
            [self.tableView footerEndRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure:%@",error);
    }] resume];
}
// 上拉刷新
- (void)headerRefresh {

    _currentPage = 1;
    [self.dataSource removeAllObjects];
    [self getData];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.tableView reloadData];
//        [self.tableView headerEndRefreshing];
//    });
}
// 下拉加载
- (void)footerRefresh {
    _currentPage ++;
    [self getData];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.tableView reloadData];
//        [self.tableView footerEndRefreshing];
//    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    YFJokeModel *model = nil;
//    if (indexPath.row < self.dataSource.count) {
//        model = self.dataSource[indexPath.row];
//    }
    YFJokeModel *model = [self.dataSource objectAtIndexCheck:indexPath.row];
    static NSString *const ID = @"JokeCell";
    YFJokeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    YFJokeModel *model = nil;
//    if (indexPath.row < self.dataSource.count) {
//        model = self.dataSource[indexPath.row];
//    }
#pragma mark - 给NSArray 添加了一个类别 防止数组越界
    YFJokeModel *model = [self.dataSource objectAtIndexCheck:indexPath.row];
    return model.intorF.size.height + 100;
}

#pragma mark - segmentControll 方法
- (void)changeDataSource:(UISegmentedControl *)segmentCT {
//    YFLog(@"%lu",segmentCT.selectedSegmentIndex);
    if (segmentCT.selectedSegmentIndex == 1) {
    
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//    static CGFloat newOffsetY = 0;
//    if (scrollView.contentOffset.y  > newOffsetY) {
//        [self.tabBarController.tabBar setHidden:YES];
//    } else if (scrollView.contentOffset.y  < newOffsetY|scrollView.contentOffset.y == 0) {
//        self.tabBarController.tabBar.hidden = NO;
//    }
//    newOffsetY = scrollView.contentOffset.y;
//    
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
//    view.backgroundColor = [UIColor redColor];
//    return view;
//}
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
