//
//  YFNewsCell.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/20.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "YFNewsCell.h"
#import "UIImageView+WebCache.h"
#import "YFNewsModel.h"
@interface YFNewsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgscrView;
@property (weak, nonatomic) IBOutlet UIImageView *imgscrView2;
@property (weak, nonatomic) IBOutlet UIImageView *imgscrView3;



@property (weak, nonatomic) IBOutlet UILabel *titleVeiw;
@property (weak, nonatomic) IBOutlet UILabel *ltitleView;
@property (weak, nonatomic) IBOutlet UILabel *replyCountView;


@end

@implementation YFNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)IDWithModel:(YFNewsModel *)model {
    if (model.imgextra.count) {
        return @"imagesCell";
    } else if (model.imgType) {
        return @"OneBigImageCell";
    } else {
        return @"newsCell";
    }
}

- (void)setModel:(YFNewsModel *)model {
    _model = model;
    self.titleVeiw.text = model.title;
    self.ltitleView.text = model.ltitle;
    self.replyCountView.text = [NSString stringWithFormat:@"%@评论",model.replyCount];
    [self.imgscrView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    if (model.imgextra.count == 2) {
        [self.imgscrView2 sd_setImageWithURL:[NSURL URLWithString:model.imgextra[0][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [self.imgscrView3 sd_setImageWithURL:[NSURL URLWithString:model.imgextra[1][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
}


@end
