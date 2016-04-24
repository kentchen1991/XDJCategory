//
//  UIView+XDJExclusiveTouch.m
//  XDJMallStandard
//
//  Created by apple on 16/3/7.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "UIView+XDJExclusiveTouch.h"
//多点触控
extern BOOL g_ExclusiveTouch;

@implementation UIView (XDJExclusiveTouch)

- (BOOL)isExclusiveTouch {
    
    return g_ExclusiveTouch;
    
}

@end
