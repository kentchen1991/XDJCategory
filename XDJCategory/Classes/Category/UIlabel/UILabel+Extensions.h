//
//  UILabel+Extensions.h
//  XDJMallStandard
//
//  Created by jolin on 16/3/16.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extensions)
/**
 *  宽度是固定，高度随着文字变化
 *
 *  @param str   文字
 *  @param width 固定宽度
 */
- (void) setLongString:(NSString *)str withFitWidth:(CGFloat)width;

@end
