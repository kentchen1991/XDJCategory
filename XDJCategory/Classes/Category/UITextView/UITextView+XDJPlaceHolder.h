//
//  UITextView+XDJPlaceHolder.h
//  XDJMallStandard
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UITextView (XDJPlaceHolder) <UITextViewDelegate>
@property (nonatomic, strong) UITextView *placeHolderTextView;
@property (nonatomic, assign) id <UITextViewDelegate> textViewDelegate;
- (void)addPlaceHolder:(NSString *)placeHolder;
@end
