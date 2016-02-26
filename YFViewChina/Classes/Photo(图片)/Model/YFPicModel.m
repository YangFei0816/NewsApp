//
//  YFPicModel.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/21.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "YFPicModel.h"

@implementation YFPicModel
+ (instancetype)modelWithDict:(NSDictionary *)dict {
    YFPicModel *model = [[self alloc] init];
    model.img = [NSArray arrayWithArray:dict[@"img"]];
    model.likeCount = dict[@"likes"];
    return model;
}
@end
