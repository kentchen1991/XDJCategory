//
//  NSString+XDJValidator.m
//  XDJMallStandard
//
//  Created by apple on 16/3/18.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "NSString+XDJValidator.h"

@implementation NSString (XDJValidator)

+ (BOOL)validLength_XDJ:(NSDictionary*)intervalDict string:(NSString*)str; {
    if (str && intervalDict) {
        NSInteger max = [intervalDict[@"max"] integerValue];
        NSInteger min = [intervalDict[@"min"] integerValue];
        if (str.length >= min && str.length <=max) {
            return YES;
        }else {
            return NO;
        }
    }
    return NO;
}

@end
