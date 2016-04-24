//
//  UILabel+Extensions.m
//  XDJMallStandard
//
//  Created by jolin on 16/3/16.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "UILabel+Extensions.h"
#import "NSString+Extensions.h"

@implementation UILabel (Extensions)

- (void)setLongString:(NSString *)str withFitWidth:(CGFloat)width{
    self.numberOfLines = 0;
    CGSize resultSize = [str sizeWithFont:self.font maxW:width];
    CGFloat resultHeight = resultSize.height;
    CGRect frame = self.frame;
    frame.size.height = resultHeight;
    frame.size.width = width;
    [self setFrame:frame];
    self.text = str;
}


@end
