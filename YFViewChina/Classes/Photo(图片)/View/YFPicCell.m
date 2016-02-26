//
//  YFPicCell.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/21.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "YFPicCell.h"
#import "YFPicModel.h"
#import "UIImageView+WebCache.h"

@interface YFPicCell ()
//@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;

@end

@implementation YFPicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(YFPicModel *)model {
    _model = model;
    self.likeCount.text = [NSString stringWithFormat:@"%@",model.likeCount];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.img[0][@"url"]] placeholderImage:nil];
}
@end
