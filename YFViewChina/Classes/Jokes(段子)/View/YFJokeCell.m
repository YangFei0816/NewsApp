//
//  YFJokeCell.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/21.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "YFJokeCell.h"
#import "YFJokeModel.h"
@interface YFJokeCell ()
@property (weak, nonatomic) IBOutlet UILabel *intorLabel;
@property (weak, nonatomic) IBOutlet UILabel *htitleView;
@property (weak, nonatomic) IBOutlet UILabel *ptimeView;

@end

@implementation YFJokeCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(YFJokeModel *)model {
    _model = model;
    self.htitleView.text = model.htitle;
    NSString *time = [model.ptime substringWithRange:NSMakeRange(10, 5)];
    self.ptimeView.text = [NSString stringWithFormat:@"%@",time];
    NSString *intorText = model.intor;
    //消除每个内容之前的乱码  &nbap;
    while (1) {
        if([intorText hasPrefix:@"&"]) {
            intorText = [intorText substringFromIndex:7];
        } else {
            self.intorLabel.text = intorText;
            break;
        }
    }
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:nil];
}
@end
