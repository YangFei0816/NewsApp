//
//  NSArray+YFUtil.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/22.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "NSArray+YFUtil.h"

@implementation NSArray (YFUtil)

- (id)objectAtIndexCheck:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}
@end
