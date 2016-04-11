//
//  UIImage+Color.h
//  SmartHeater
//
//  Created by Nick.Lin on 15/2/28.
//  Copyright (c) 2015年 changhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size;

@end
