//
//  UIView+Extensions.m
//  XDJMallStandard
//
//  Created by jolin on 16/3/11.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "UIView+Extensions.h"
#import "XDJConstant.h"

#define kTagBadgeView  1000
#define kTagBadgePointView  1001

@implementation UIView (Extensions)

- (UIView *)addLineViewWithPointY:(CGFloat)pointY  height:(CGFloat)height{
    return [self addLineViewWithPointY:pointY andColor:RGB_XDJ(200, 200, 205) andLeftSpace:0 andRightSpace:0 height:height];
}

- (UIView *)addLineViewWithPointY:(CGFloat)pointY{
    return [self addLineViewWithPointY:pointY andColor:RGB_XDJ(200, 200, 205) ];
}


- (UIView *)addLineViewWithPointY:(CGFloat)pointY andColor:(UIColor *)color{
    return  [self addLineViewWithPointY:pointY andColor:color andLeftSpace:0 andRightSpace:0];
}

- (UIView *)addLineViewWithPointY:(CGFloat)pointY  andLeftSpace:(CGFloat)leftSpace andRightSpace:(CGFloat)rightSpace{
    return [self addLineViewWithPointY:pointY andColor:RGB_XDJ(200, 200, 205) andLeftSpace:leftSpace andRightSpace:rightSpace];
}

- (UIView *)addLineViewWithPointY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace andRightSpace:(CGFloat)rightSpace{
    return [self addLineViewWithPointY:pointY andColor:color andLeftSpace:leftSpace andRightSpace:rightSpace height:0.5];
}

- (UIView *)addLineViewWithPointY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace andRightSpace:(CGFloat)rightSpace height:(CGFloat)height{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(leftSpace, pointY, CGRectGetWidth(self.frame) - leftSpace - rightSpace, height)];
    lineView.backgroundColor = color;
    [self addSubview:lineView];
    return lineView;
}


- (void)removeAllSubViews{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (UIViewController *)findViewController{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

// //////////////////////BadgeTip/////////////////////////////////////////////
- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center{
    if (!badgeValue || !badgeValue.length) {
        [self removeBadgeTips];
    }else{
        UIView *badgeV = [self viewWithTag:kTagBadgeView];
        if (badgeV && [badgeV isKindOfClass:[UIBadgeView class]]) {
            [(UIBadgeView *)badgeV setBadgeValue:badgeValue];
            badgeV.hidden = NO;
        }else{
            badgeV = [UIBadgeView viewWithBadgeTip:badgeValue];
            badgeV.tag = kTagBadgeView;
            [self addSubview:badgeV];
        }
        [badgeV setCenter:center];
    }
}
- (void)addBadgeTip:(NSString *)badgeValue{
    if (!badgeValue || !badgeValue.length) {
        [self removeBadgeTips];
    }else{
        UIView *badgeV = [self viewWithTag:kTagBadgeView];
        if (badgeV && [badgeV isKindOfClass:[UIBadgeView class]]) {
            [(UIBadgeView *)badgeV setBadgeValue:badgeValue];
        }else{
            badgeV = [UIBadgeView viewWithBadgeTip:badgeValue];
            badgeV.tag = kTagBadgeView;
            [self addSubview:badgeV];
        }
        
        CGSize badgeSize = badgeV.frame.size;
        CGSize selfSize = self.frame.size;
        CGFloat offset = 2.0;
        [badgeV setCenter:CGPointMake(selfSize.width- (offset+badgeSize.width/2),
                                      (offset +badgeSize.height/2))];
    }
}
- (void)removeBadgeTips{
    NSArray *subViews =[self subviews];
    if (subViews && [subViews count] > 0) {
        for (UIView *aView in subViews) {
            if (aView.tag == kTagBadgeView && [aView isKindOfClass:[UIBadgeView class]]) {
                aView.hidden = YES;
            }
        }
    }
}

// //////////////////////////////////////////////////////////////////////////////////////

@end
