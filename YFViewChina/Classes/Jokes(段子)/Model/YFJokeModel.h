//
//  YFJokeModel.h
//  YFViewChina
//
//  Created by qianfneg on 16/1/21.
//  Copyright © 2016年 杨飞. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class YFJokeModel;
@interface YFJokeModel : NSObject
@property (nonatomic, assign) CGRect intorF;
@property (nonatomic, copy) NSString *htitle;
@property (nonatomic, copy) NSString *intor;
@property (nonatomic, copy) NSString *ptime;

@property (nonatomic, copy) NSString *picUrl;


+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
