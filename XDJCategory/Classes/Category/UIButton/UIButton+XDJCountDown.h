//
//  UIButton+XDJCountDown.h
//  XDJMallStandard
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (XDJCountDown)
-(void)startTime:(NSInteger )timeout title:(NSString *)tittle waitTittle:(NSString *)waitTittle;
@end
