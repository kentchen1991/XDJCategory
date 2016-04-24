//
//  NSString+XDJHelper.m
//  XDJMallStandard
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "NSString+XDJHelper.h"
@import CoreGraphics;


@implementation NSString (XDJHelper)

+ (NSString*)appendingLeft:(NSString*)leftString rightString:(NSString*)rightString {
    NSString *result = [NSString stringWithFormat:@"%@%@",leftString,rightString];
    return result;
}

//返回字符串所占用的尺寸.
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
