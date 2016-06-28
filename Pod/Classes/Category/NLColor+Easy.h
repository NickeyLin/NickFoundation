//
//  NLColor+Easy.h
//  CHMobileUISDK
//
//  Created by Nick.Lin on 15/9/29.
//  Copyright © 2015年 ChangHong. All rights reserved.
//

#ifndef NLColor
#if TARGET_OS_IOS
#define NLColor UIColor
#define NLImage UIImage
#import <UIKit/UIKit.h>

#else
#define NLColor NSColor
#define NLImage NSImage
#endif
#endif

@interface NLColor (EasyHex)
// 颜色空间
@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;
// 是否提供了RGB通道
@property (nonatomic, readonly) BOOL canProvideRGBComponents;
// 红色通道值
@property (nonatomic, readonly) CGFloat red; // Only valid if canProvideRGBComponents is YES
// 绿色通道值
@property (nonatomic, readonly) CGFloat green; // Only valid if canProvideRGBComponents is YES
// 蓝色通道值
@property (nonatomic, readonly) CGFloat blue; // Only valid if canProvideRGBComponents is YES
// 灰度色
@property (nonatomic, readonly) CGFloat white; // Only valid if colorSpaceModel == kCGColorSpaceModelMonochrome
// 透明度
@property (nonatomic, readonly) CGFloat alpha;
// rgb整数值
@property (nonatomic, readonly) UInt32 rgbHex;

- (NSString *)colorSpaceString;

- (NSArray *)arrayFromRGBAComponents;

- (BOOL)red:(CGFloat *)r green:(CGFloat *)g blue:(CGFloat *)b alpha:(CGFloat *)a;

- (NLColor *)colorByLuminanceMapping;

- (NLColor *)colorByMultiplyingByRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (NLColor *)colorByAddingRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (NLColor *)colorByLighteningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (NLColor *)colorByDarkeningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

- (NLColor *)colorByMultiplyingBy:(CGFloat)f;
- (NLColor *)colorByAdding:(CGFloat)f;
- (NLColor *)colorByLighteningTo:(CGFloat)f;
- (NLColor *)colorByDarkeningTo:(CGFloat)f;

- (NLColor *)colorByMultiplyingByColor:(NLColor *)color;
- (NLColor *)colorByAddingColor:(NLColor *)color;
- (NLColor *)colorByLighteningToColor:(NLColor *)color;
- (NLColor *)colorByDarkeningToColor:(NLColor *)color;

- (NSString *)stringFromColor;
- (NSString *)hexStringFromColor;

+ (NLColor *)randomColor;

// format:{R(0-255),G(0-255),B(0-255),A(0-255)} OR {W(0-255),A(0-255)}
+ (NLColor *)colorWithString:(NSString *)stringToConvert;

+ (NLColor *)colorWithRGBHex:(NSUInteger)hex;
+ (NLColor *)colorWithARGBHex:(NSUInteger)hex;
+ (NLColor *)colorWithHexString:(NSString *)stringToConvert;
@end

@interface NLImage (Color)
// 根据颜色来生成图片
+ (NLImage *)createImageWithColor:(NLColor *)color;
+ (NLImage *)createImageWithColor:(NLColor *)color withSize:(CGSize)size;
@end
