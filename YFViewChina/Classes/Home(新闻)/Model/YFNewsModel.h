//
//  YFNewsModel.h
//  YFViewChina
//
//  Created by qianfneg on 16/1/20.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFNewsModel : NSObject
/**
 *  每个cell的大标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  cell下边的子标题
 */
@property (nonatomic, copy) NSString *ltitle;
/**
 *  每个cell的左边图片连接
 */
@property (nonatomic, copy) NSString *imgsrc;
/**
 *  跟帖数
 */
/**
 *  url
 */
@property (nonatomic, copy) NSString *url_3w;

@property (nonatomic, strong) NSNumber *replyCount;
/**
 *  cell对应的url
 */
@property (nonatomic, copy) NSString *url;
/**
 *  三张图的cell
 */
@property (nonatomic, strong) NSArray *imgextra;

//三张图的url
@property (nonatomic, copy) NSString *photosetID;
@property (nonatomic, copy) NSString *threePicUrl;
/**
 *  一横条的cell
 */
@property (nonatomic, strong) NSNumber *imgType;


+ (instancetype)newsModelWithDict:(NSDictionary *)dict;

@end











