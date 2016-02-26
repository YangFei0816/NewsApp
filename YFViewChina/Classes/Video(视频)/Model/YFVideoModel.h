//
//  YFVideoModel.h
//  YFViewChina
//
//  Created by qianfneg on 16/1/23.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFVideoModel : NSObject
@property (nonatomic, copy) NSString *videoUrl;
@property (nonatomic, copy) NSString *textLab;
@property (nonatomic, copy) NSString *duration;
@property (nonatomic, copy) NSString *thumbnail;



+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
