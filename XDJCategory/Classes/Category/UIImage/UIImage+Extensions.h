//
//  UIImage+Extensions.h
//  TMarket
//
//  Created by ZhangAo on 12/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define stretchImgFromMiddle(img)	[(img) stretchableImageWithLeftCapWidth:(img).size.width / 2 topCapHeight:(img).size.height / 2]

@interface UIImage (Extensions)
/**
 *  拉伸图片
 */
- (UIImage *)stretcheImage:(UIImage *)img;

-(UIImage *)synthesizeImage:(UIImage *)image;

-(UIImage *)imageByScalingAndCroppingForSize:(CGSize)cropSize;

-(UIImage *)imageForMask:(UIImage *)maskImage;

+(UIImage *)imageFromColor:(UIColor *)color;

+(UIImage *)imageFromColor:(UIColor *)color cornerRadius:(CGFloat)radius;
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
// UIImage的磨砂效果
-(UIImage *)rn_boxblurImageWithBlur:(CGFloat)blur exclusionPath:(UIBezierPath *)exclusionPath;

@end
