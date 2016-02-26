//
//  YFNewsModel.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/20.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "YFNewsModel.h"

@implementation YFNewsModel
+ (instancetype)newsModelWithDict:(NSDictionary *)dict {
    YFNewsModel *model = [[YFNewsModel alloc] init];
    model.imgsrc = dict[@"imgsrc"];
    model.title = dict[@"title"];
    model.ltitle = dict[@"ltitle"];
    model.replyCount = dict[@"replyCount"];
    model.imgType = dict[@"imgType"];
//    model.url = dict[@"url"];
    model.url_3w = dict[@"url"];
    model.imgextra = [NSArray arrayWithArray:dict[@"imgextra"]];
    model.photosetID = dict[@"photosetID"];
    model.threePicUrl = [model covertURL:model.photosetID];
    return model;
}
- (NSString *)covertURL:(NSString *)photoSetID {
    // 取出关键字
    NSString *one  = photoSetID;
//    NSString *two = [one substringFromIndex:4];
    NSArray *three = [one componentsSeparatedByString:@"|"];
    return [NSString stringWithFormat:@"http://news.163.com/photoview/%@/%@.html",[three firstObject],[three lastObject]];
    
}
@end
