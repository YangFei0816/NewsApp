//
//  YFVideoModel.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/23.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "YFVideoModel.h"

@implementation YFVideoModel
+ (instancetype)modelWithDict:(NSDictionary *)dict {
    YFVideoModel *model = [[self alloc] init];
    model.videoUrl = dict[@"video"][@"video"][0];
    model.textLab = dict[@"text"];
    model.duration = dict[@"video"][@"duration"];
    model.thumbnail = dict[@"video"][@"thumbnail"][0];
 
    return model;
}
@end
