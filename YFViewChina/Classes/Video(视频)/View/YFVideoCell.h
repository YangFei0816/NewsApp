//
//  YFVideoCell.h
//  YFViewChina
//
//  Created by qianfneg on 16/1/23.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFVideoModel;
@interface YFVideoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoView;
@property (nonatomic, strong) YFVideoModel *model;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;


@end
