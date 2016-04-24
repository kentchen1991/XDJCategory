//
//  NSString+XDJDate.m
//  XDJMallStandard
//
//  Created by apple on 16/3/18.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "NSString+XDJDate.h"

@implementation NSString (XDJDate)

+ (NSString*)changeDateWithFormat:(NSString*)formatStr andDate:(NSDate*)date {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatStr];
    return [formatter stringFromDate:date];
    
}

+ (NSString *)changeFullTime:(NSString*)createdAt andFormatter:(NSString*)format {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[createdAt doubleValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
    
}
@end
