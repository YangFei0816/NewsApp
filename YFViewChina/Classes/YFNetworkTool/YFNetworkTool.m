//
//  YFNetworkTool.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/20.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "YFNetworkTool.h"

@implementation YFNetworkTool
+ (instancetype)sharedNetworkTool {
    static YFNetworkTool *manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //创建初始化的baseUrl
        NSURL *url = [NSURL URLWithString:@"http://c.3g.163.com/"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        manger = [[self alloc] initWithBaseURL:url sessionConfiguration:config];
        manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return manger;
}
+ (instancetype)sharedNetworkToolWithoutBaseUrl {
    static YFNetworkTool *manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //没有指定初始化的url
        NSURL *url = [NSURL URLWithString:@""];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        manger = [[self alloc] initWithBaseURL:url sessionConfiguration:config];
        manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return manger;
}
@end
