//
//  NLColor+Easy.m
//  CHMobileUISDK
//
//  Created by Nick.Lin on 15/9/29.
//  Copyright © 2015年 ChangHong. All rights reserved.
//

#import "NLColor+Easy.h"

@implementation NLColor (EasyHex)
- (CGColorSpaceModel)colorSpaceModel {
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (NSString *)colorSpaceString {
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (BOOL)canProvideRGBComponents {
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelRGB:
        case kCGColorSpaceModelMonochrome:
            return YES;
        default:
            return NO;
    }
}

- (NSArray *)arrayFromRGBAComponents {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -arrayFromRGBAComponents");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [NSArray arrayWithObjects:
            [NSNumber numberWithFloat:r],
            [NSNumber numberWithFloat:g],
            [NSNumber numberWithFloat:b],
            [NSNumber numberWithFloat:a],
            nil];
}

- (BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r,g,b,a;
    
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelMonochrome:
            r = g = b = components[0];
            a = components[1];
            break;
        case kCGColorSpaceModelRGB:
            r = components[0];
            g = components[1];
            b = components[2];
            a = components[3];
            break;
        default: // We don't know how to handle this model
            return NO;
    }
    
    if (red) *red = r;
    if (green) *green = g;
    if (blue) *blue = b;
    if (alpha) *alpha = a;
    
    return YES;
}

- (CGFloat)red {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -red");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)green {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -green");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[1];
}

- (CGFloat)blue {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -blue");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[2];
}

- (CGFloat)white {
    NSAssert(self.colorSpaceModel == kCGColorSpaceModelMonochrome, @"Must be a Monochrome color to use -white");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

- (UInt32)rgbHex {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use rgbHex");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return 0;
    
    r = MIN(MAX(self.red, 0.0f), 1.0f);
    g = MIN(MAX(self.green, 0.0f), 1.0f);
    b = MIN(MAX(self.blue, 0.0f), 1.0f);
    
    return (((int)roundf(r * 255)) << 16)
    | (((int)roundf(g * 255)) << 8)
    | (((int)roundf(b * 255)));
}

#pragma mark Arithmetic operations

- (NLColor *)colorByLuminanceMapping {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    // http://en.wikipedia.org/wiki/Luma_(video)
    // Y = 0.2126 R + 0.7152 G + 0.0722 B
    return [NLColor colorWithWhite:r*0.2126f + g*0.7152f + b*0.0722f
                             alpha:a];
    
}

- (NLColor *)colorByMultiplyingByRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [NLColor colorWithRed:MAX(0.0, MIN(1.0, r * red))
                           green:MAX(0.0, MIN(1.0, g * green))
                            blue:MAX(0.0, MIN(1.0, b * blue))
                           alpha:MAX(0.0, MIN(1.0, a * alpha))];
}

- (NLColor *)colorByAddingRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [NLColor colorWithRed:MAX(0.0, MIN(1.0, r + red))
                           green:MAX(0.0, MIN(1.0, g + green))
                            blue:MAX(0.0, MIN(1.0, b + blue))
                           alpha:MAX(0.0, MIN(1.0, a + alpha))];
}

- (NLColor *)colorByLighteningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [NLColor colorWithRed:MAX(r, red)
                           green:MAX(g, green)
                            blue:MAX(b, blue)
                           alpha:MAX(a, alpha)];
}

- (NLColor *)colorByDarkeningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [NLColor colorWithRed:MIN(r, red)
                           green:MIN(g, green)
                            blue:MIN(b, blue)
                           alpha:MIN(a, alpha)];
}

- (NLColor *)colorByMultiplyingBy:(CGFloat)f {
    return [self colorByMultiplyingByRed:f green:f blue:f alpha:1.0f];
}

- (NLColor *)colorByAdding:(CGFloat)f {
    return [self colorByMultiplyingByRed:f green:f blue:f alpha:0.0f];
}

- (NLColor *)colorByLighteningTo:(CGFloat)f {
    return [self colorByLighteningToRed:f green:f blue:f alpha:0.0f];
}

- (NLColor *)colorByDarkeningTo:(CGFloat)f {
    return [self colorByDarkeningToRed:f green:f blue:f alpha:1.0f];
}

- (NLColor *)colorByMultiplyingByColor:(NLColor *)color {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [self colorByMultiplyingByRed:r green:g blue:b alpha:1.0f];
}

- (NLColor *)colorByAddingColor:(NLColor *)color {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [self colorByAddingRed:r green:g blue:b alpha:0.0f];
}

- (NLColor *)colorByLighteningToColor:(NLColor *)color {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [self colorByLighteningToRed:r green:g blue:b alpha:0.0f];
}

- (NLColor *)colorByDarkeningToColor:(NLColor *)color {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmatic operations");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [self colorByDarkeningToRed:r green:g blue:b alpha:1.0f];
}

#pragma mark String utilities

- (NSString *)stringFromColor {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -stringFromColor");
    NSString *result;
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelRGB:
            result = [NSString stringWithFormat:@"{%0.3f, %0.3f, %0.3f, %0.3f}", self.red, self.green, self.blue, self.alpha];
            break;
        case kCGColorSpaceModelMonochrome:
            result = [NSString stringWithFormat:@"{%0.3f, %0.3f}", self.white, self.alpha];
            break;
        default:
            result = nil;
    }
    return result;
}

- (NSString *)hexStringFromColor {
    return [NSString stringWithFormat:@"%0.6X", (unsigned int)self.rgbHex];
}

+ (NLColor *)colorWithString:(NSString *)stringToConvert {
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    if (![scanner scanString:@"{" intoString:NULL]) return nil;
    const NSUInteger kMaxComponents = 4;
    NSInteger c[kMaxComponents];
    NSUInteger i = 0;
    if (![scanner scanInteger:&c[i++]]) return nil;
    while (1) {
        if ([scanner scanString:@"}" intoString:NULL]) break;
        if (i >= kMaxComponents) return nil;
        if ([scanner scanString:@"," intoString:NULL]) {
            if (![scanner scanInteger:&c[i++]]) return nil;
        } else {
            // either we're at the end of there's an unexpected character here
            // both cases are error conditions
            return nil;
        }
    }
    if (![scanner isAtEnd]) return nil;
    NLColor *color;
    switch (i) {
        case 2: // monochrome
            color = [NLColor colorWithWhite:(c[0] / 255.0f) alpha:(c[1] / 255.0f)];
            break;
        case 4: // RGB
            color = [NLColor colorWithRed:(c[0] / 255.0f) green:(c[1] / 255.0f) blue:(c[2] / 255.0f) alpha:(c[3] / 255.0f)];
            break;
        default:
            color = nil;
    }
    return color;
}

#pragma mark Class methods

+ (NLColor *)randomColor {
    return [NLColor colorWithRed:(CGFloat)RAND_MAX / random()
                           green:(CGFloat)RAND_MAX / random()
                            blue:(CGFloat)RAND_MAX / random()
                           alpha:1.0f];
}

+ (NLColor *)colorWithRGBHex:(NSUInteger)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [NLColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

+ (NLColor *)colorWithARGBHex:(NSUInteger)hex{
    int b = hex & 0x000000FF;
    int g = ((hex & 0x0000FF00) >> 8);
    int r = ((hex & 0x00FF0000) >> 16);
    int a = ((hex & 0xFF000000) >> 24);
    
    return [NLColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:a / 255.f];
}

// Returns a NLColor by scanning the string for a hex number and passing that to +[NLColor colorWithRGBHex:]
// Skips any leading whitespace and ignores any trailing characters
+ (NLColor *)colorWithHexString:(NSString *)stringToConvert {
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [NLColor colorWithRGBHex:hexNum];
}

@end

@implementation NLImage (Color)


+ (NLImage *)createImageWithColor:(NLColor *)color{
    
    return [self createImageWithColor:color withSize:CGSizeMake(1, 1)];
}

+ (NLImage *)createImageWithColor:(NLColor *)color withSize:(CGSize)size{
#if TARGET_OS_IOS
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
#else
    NSImage *image = [[NSImage alloc] initWithSize:size];
    [image lockFocus];
    [color drawSwatchInRect:NSMakeRect(0, 0, size.width, size.height)];
    [image unlockFocus];
    return image;
#endif
}

@end
