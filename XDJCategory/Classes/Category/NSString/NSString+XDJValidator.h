//
//  NSString+XDJValidator.h
//  XDJMallStandard
//
//  Created by apple on 16/3/18.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XDJValidator)
/**
 *  验证长度
 *
 *  @param intervalDict 区间字典@{max:xx,min:xx}
 */
+ (BOOL)validLength_XDJ:(NSDictionary*)intervalDict string:(NSString*)str;

@end
