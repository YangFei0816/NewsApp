//
//  YFPicModel.h
//  YFViewChina
//
//  Created by qianfneg on 16/1/21.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFPicModel : NSObject
@property (nonatomic, strong) NSArray *img;
@property (nonatomic, strong) NSNumber *likeCount;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
