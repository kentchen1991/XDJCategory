//
//  UIView+Extensions.h
//  XDJMallStandard
//
//  Created by jolin on 16/3/11.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBadgeView.h"

@interface UIView (Extensions)

- (UIView *)addLineViewWithPointY:(CGFloat)pointY;
- (UIView *)addLineViewWithPointY:(CGFloat)pointY  height:(CGFloat)height;
- (UIView *)addLineViewWithPointY:(CGFloat)pointY andColor:(UIColor *)color;
- (UIView *)addLineViewWithPointY:(CGFloat)pointY  andLeftSpace:(CGFloat)leftSpace andRightSpace:(CGFloat)rightSpace;
- (UIView *)addLineViewWithPointY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace andRightSpace:(CGFloat)rightSpace;
- (UIView *)addLineViewWithPointY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace andRightSpace:(CGFloat)rightSpace height:(CGFloat)height;


- (void)removeAllSubViews;

- (UIViewController *)findViewController;

- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center;
- (void)addBadgeTip:(NSString *)badgeValue;
- (void)removeBadgeTips;

@end
