//
//  YFMainTabBarController.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/18.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "YFMainTabBarController.h"

@interface YFMainTabBarController ()

@end

@implementation YFMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//   ,@"tabbar_picture_hl.png"
    NSArray *imageArray = @[@"tabbar_news_hl.png",@"tabbar_video_hl",@"tabbar_setting_hl",@"tabbar_picture_hl"];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selectedImage = [[UIImage imageNamed:imageArray[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
