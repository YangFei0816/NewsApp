//
//  YFPicTableViewController.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/21.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "YFPicTableViewController.h"
#import "YFPicCell.h"
#import "YFPicModel.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
#import "StatusBarHUD.h"
#define URL_STR (@"http://api.3g.ifeng.com/clientShortNews?type=beauty&page=")

@interface YFPicTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation YFPicTableViewController

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
//加载数据
- (void)getData {
    //拼接urlString
    NSString *urlString = [NSString stringWithFormat:@"%@%ld",URL_STR,_currentPage];
    [[[AFHTTPSessionManager manager] GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
        NSArray *dataArray = responseObject[@"body"];
        NSMutableArray *modelArray = [NSMutableArray array];
        for (NSDictionary *dict in dataArray) {
            YFPicModel *model = [YFPicModel modelWithDict:dict];
            [modelArray addObject:model];
        }
        [self.dataSource addObjectsFromArray:modelArray];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failure:%@",error);
    }] resume];
}
// 上拉刷新
- (void)headerRefresh {
    _currentPage = 1;
    [self.dataSource removeAllObjects];
    [self performSelector:@selector(getData) withObject:nil afterDelay:0.5];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    });
}
// 下拉加载
- (void)footerRefresh {
    _currentPage ++;
    [self performSelector:@selector(getData) withObject:nil afterDelay:0.5];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
    });
}

- (void)viewWillAppear:(BOOL)animated {
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [self.tabBarController.tabBar setHidden:YES];

    UILongPressGestureRecognizer *lpg = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(savePictureToAlbum:)];
    [self.view addGestureRecognizer:lpg];
}
//- (void)changeStatus {
//    //单击隐藏tabBar
//    BOOL isHiddenTabBar = ![self.tabBarController.tabBar isHidden];
//    [self.tabBarController.tabBar setHidden:isHiddenTabBar];
//    //隐藏navigationBar
//    BOOL isHiddenNav = ![self.navigationController.navigationBar isHidden];
//    [self.navigationController.navigationBar setHidden:isHiddenNav];
//    //刷新状态栏
//    [self setNeedsStatusBarAppearanceUpdate];
//   
//}
- (BOOL)prefersStatusBarHidden {
    return self.tabBarController.tabBar.isHidden;
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YFPicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PicCell"];
#pragma mark - 给NSArray添加类别 防止数组越界
    YFPicModel *model = [self.dataSource objectAtIndexCheck:indexPath.row];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YFPicModel *model = [self.dataSource objectAtIndexCheck:indexPath.row];
    //图片高度
    double height = [model.img[0][@"size"][@"height"] doubleValue];
    //图片宽度
    double width = [model.img[0][@"size"][@"width"] doubleValue];
    //按比例获取cell高度
    CGFloat rowHeight = [UIScreen mainScreen].bounds.size.width * (height/width) + 30;//消除底下label影响
    return rowHeight;
}
#pragma mark - ******************** 保存到相册方法
- (void)savePictureToAlbum:(UILongPressGestureRecognizer *)lpg {
    // 长按手势可能背会连续调用俩次, 会有警告, 要判断一下
    if (lpg.state == UIGestureRecognizerStateBegan) return;
    /** 获取手势按的地方对应的cell 的 indexPath   */
    CGPoint p = [lpg locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
    YFPicModel *model = [self.dataSource objectAtIndexCheck:indexPath.row];
    NSString *urlStr = model.img[0][@"url"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要保存到相册吗 ？" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//        NSURLCache *cache =[NSURLCache sharedURLCache];
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://img1.pengfu.cn/middle/289/1005289.jpg"]];
//        NSData *imgData = [cache cachedResponseForRequest:request].data;
//        UIImage *image = [UIImage imageWithData:imgData];
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlStr] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image: didFinishSavingWithError: contextInfo:), nil);
        }];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}
//图片保存成功以后会调用这个方法 弹出保存成功或者失败提示
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:error ? @"保存失败":@"保存成功"preferredStyle:UIAlertControllerStyleAlert];
//        [self presentViewController:alert animated:YES completion:nil];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [alert dismissViewControllerAnimated:YES completion:nil];
//        });
    if (error) { // 图片保存失败
        [StatusBarHUD showError:@"图片保存失败"];
    } else { // 图片保存成功
        [StatusBarHUD showSuccess:@"图片保存成功"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
