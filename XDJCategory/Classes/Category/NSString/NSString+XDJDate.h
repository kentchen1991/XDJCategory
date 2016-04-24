//
//  NSString+XDJDate.h
//  XDJMallStandard
//
//  Created by apple on 16/3/18.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XDJDate)

+(NSString*)changeDateWithFormat:(NSString*)formatStr andDate:(NSDate*)date;
+ (NSString *)changeFullTime:(NSString*)createdAt andFormatter:(NSString*)format;
@end
