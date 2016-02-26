//
//  UIView+Hud.h
//  YFViewChina
//
//  Created by qianfneg on 16/1/27.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIView (Hud)
@property (nonatomic, strong) MBProgressHUD *hud;
- (void)showHud;
- (void)hideHud;
@end
