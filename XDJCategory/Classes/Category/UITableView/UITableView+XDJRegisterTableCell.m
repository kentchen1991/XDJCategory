//
//  UITableView+XDJRegisterTableCell.m
//  XDJMallStandard
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "UITableView+XDJRegisterTableCell.h"
#import <objc/runtime.h>
@implementation UITableView (XDJRegisterTableCell)

-(void)registerCell:(NSArray*)cellStringArr {
    [cellStringArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *classStr = cellStringArr[idx];
        Class someClass = NSClassFromString(classStr);
        [self registerClass:someClass forCellReuseIdentifier:classStr];
    }];
}

@end
