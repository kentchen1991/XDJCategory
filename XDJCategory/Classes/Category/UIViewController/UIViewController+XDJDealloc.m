//
//  UIViewController+XDJDealloc.m
//  XDJMallStandard
//
//  Created by jolin on 16/3/17.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "UIViewController+XDJDealloc.h"
#import <objc/runtime.h>

@implementation UIViewController (XDJDealloc)

+ (void)load{
#ifdef DEBUG
    Method method1 = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod(self, @selector(xdj_dealloc));
    method_exchangeImplementations(method1, method2);
#endif
}



- (void)xdj_dealloc{
    NSLog(@"%@ ==>> 消失了",[NSString stringWithUTF8String:object_getClassName(self)]);
    [self xdj_dealloc];
}

@end
