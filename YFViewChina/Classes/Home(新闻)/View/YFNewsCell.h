//
//  YFNewsCell.h
//  YFViewChina
//
//  Created by qianfneg on 16/1/20.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFNewsModel;
@interface YFNewsCell : UITableViewCell
@property (nonatomic,strong) YFNewsModel *model;
+ (NSString *)IDWithModel:(YFNewsModel *)model;
@end
