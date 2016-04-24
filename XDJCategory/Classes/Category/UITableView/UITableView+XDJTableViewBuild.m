//
//  UITableView+XDJTableViewBuild.m
//  XDJMallStandard
//
//  Created by csh on 16/4/14.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "UITableView+XDJTableViewBuild.h"
#import "XDJConstant.h"

@implementation UITableView (XDJTableViewBuild)
+ (UITableView *)buildCommonXDJtableViewWithDelegate:(UIViewController<UITableViewDelegate,UITableViewDataSource>*)vc
{
    UITableView *tableView =  [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = common_background_color;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = vc;
    tableView.dataSource = vc;
    return tableView;
}

@end
