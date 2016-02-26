//
//  YFDetailViewController.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/21.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "YFDetailViewController.h"
#import "UIView+Hud.h"

@interface YFDetailViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation YFDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.scrollView.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    
}
- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.webView = nil;
}

#pragma mark - UIWebViewDelegate
//- (void)webViewDidStartLoad:(UIWebView *)webView {
//    NSLog(@"++++++++++++++%@",webView.request.URL);
//    [self.view showHud];
//
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [self.view hideHud];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
