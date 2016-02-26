//
//  NSArray+YFUtil.h
//  YFViewChina
//
//  Created by qianfneg on 16/1/22.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YFUtil)
/*!
 @method objectAtIndexCheck:
 @abstract 检查是否越界和NSNull如果是返回nil
 @result 返回对象
 */
- (id)objectAtIndexCheck:(NSUInteger)index;
@end
