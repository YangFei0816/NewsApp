//
//  YFVideoCell.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/23.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "YFVideoCell.h"
#import "YFVideoModel.h"
#import "UIImageView+WebCache.h"
@interface YFVideoCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *durationView;

@end

@implementation YFVideoCell

- (void)awakeFromNib {
    // Initialization code
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(YFVideoModel *)model {
    _model = model;
    self.titleView.text = model.textLab;
    NSString *minute = [NSString stringWithFormat:@"%.2d",model.duration.intValue/60];
    NSString *second = [NSString stringWithFormat:@"%.2d",model.duration.intValue%60];
    self.durationView.text = [NSString stringWithFormat:@"%@:%@",minute,second];
    [self.videoView setContentMode:UIViewContentModeScaleAspectFit];
    [self.videoView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:nil];
    
}

@end
