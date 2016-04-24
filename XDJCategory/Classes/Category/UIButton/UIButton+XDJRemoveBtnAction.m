//
//  UIButton+XDJRemoveBtnAction.m
//  XDJMallStandard
//
//  Created by csh on 16/4/12.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "UIButton+XDJRemoveBtnAction.h"

@implementation UIButton (XDJRemoveBtnAction)

+ (void)removeBtnTarget:(UIButton*)btn target:(NSObject*)target {
    NSArray *arr = [btn actionsForTarget:target forControlEvent:UIControlEventTouchUpInside];
    if (!arr) {
        return;
    }
    [arr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SEL selector = NSSelectorFromString(obj);
        [btn removeTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }];
}


@end
