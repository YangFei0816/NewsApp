//
//  YFPicCell.h
//  YFViewChina
//
//  Created by qianfneg on 16/1/21.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFPicModel;
@interface YFPicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (nonatomic, strong) YFPicModel *model;
@end
