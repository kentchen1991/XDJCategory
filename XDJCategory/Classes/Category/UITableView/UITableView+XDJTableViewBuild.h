//
//  UITableView+XDJTableViewBuild.h
//  XDJMallStandard
//
//  Created by csh on 16/4/14.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (XDJTableViewBuild)

+ (UITableView*)buildCommonXDJtableViewWithDelegate:(UIViewController<UITableViewDelegate,UITableViewDataSource>*)vc;

@end
