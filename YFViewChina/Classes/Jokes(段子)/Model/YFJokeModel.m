//
//  YFJokeModel.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/21.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "YFJokeModel.h"

@implementation YFJokeModel
+ (instancetype)modelWithDict:(NSDictionary *)dict {
    YFJokeModel *model = [[self alloc] init];
    model.htitle = dict[@"htitle"];
    model.intor = dict[@"intor"];
    model.ptime = dict[@"ptime"];
    model.picUrl = dict[@"picUrl"];
    model.intorF = [dict[@"intor"] boundingRectWithSize:CGSizeMake(375, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    return model;
}

@end
