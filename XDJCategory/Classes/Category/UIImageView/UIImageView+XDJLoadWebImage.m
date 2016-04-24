//
//  UIImageView+XDJLoadWebImage.m
//  XDJMallStandard
//
//  Created by jolin on 16/3/29.
//  Copyright © 2016年 XDJ. All rights reserved.
//

#import "UIImageView+XDJLoadWebImage.h"
#import "YYWebImage.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (XDJLoadWebImage)

- (void)yy_loadImageWithUrl:(NSString *)url
{
    [self yy_setImageWithURL:[NSURL URLWithString:url]
                 placeholder:[UIImage imageNamed:@"default_image"]
                     options:YYWebImageOptionSetImageWithFadeAnimation |
     YYWebImageOptionProgressiveBlur           |
     YYWebImageOptionShowNetworkActivity
                  completion:nil];
}

- (void)sd_loadImageWithUrl:(NSString *)url {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"icon" ofType:@"png"];
    [self sd_setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:[UIImage imageWithContentsOfFile:path]];
    
}

@end
