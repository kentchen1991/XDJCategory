//
//  UITextView+XDJPlaceHolder.m
//  XDJMallStandard
//
//  Created by apple on 16/3/14.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "UITextView+XDJPlaceHolder.h"
static const char *phTextView = "placeHolderTextView";
static const char *txtViewDelegate = "txtViewDelegate";

@implementation UITextView (XDJPlaceHolder)
- (UITextView *)placeHolderTextView {
    return objc_getAssociatedObject(self, phTextView);
}

- (void)setPlaceHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, phTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<UITextViewDelegate>)textViewDelegate {
    return objc_getAssociatedObject(self, txtViewDelegate);
}

- (void)setTextViewDelegate:(id<UITextViewDelegate>)textViewDelegate {
    objc_setAssociatedObject(self, txtViewDelegate, textViewDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (void)addPlaceHolder:(NSString *)placeHolder {
    if (![self placeHolderTextView]) {
        self.delegate = self;
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setPlaceHolderTextView:textView];
    }
}
# pragma mark -
# pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeHolderTextView.hidden = YES;
    if ([self.textViewDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        [self.textViewDelegate textViewShouldBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text && [textView.text isEqualToString:@""]) {
        self.placeHolderTextView.hidden = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([self.textViewDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [self.textViewDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }else{
        return YES;
    }
    
}

@end
