//
//  YFNetworkTool.h
//  YFViewChina
//
//  Created by qianfneg on 16/1/20.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface YFNetworkTool : AFHTTPSessionManager
+ (instancetype)sharedNetworkTool;
+ (instancetype)sharedNetworkToolWithoutBaseUrl;
@end
