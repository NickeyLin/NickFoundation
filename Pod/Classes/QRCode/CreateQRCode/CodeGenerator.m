//
//  RSCodeGenerator.m
//  RSBarcodes
//
//  Created by R0CKSTAR on 12/25/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//
#if TARGET_OS_IOS

#import "CodeGenerator.h"

@implementation BaseCodeGenerator

NSString *const DIGITS_STRING = @"0123456789";

- (BOOL)isContentsValid:(NSString *)contents {
    if (contents.length > 0) {
        for (int i = 0; i < contents.length; i++) {
            if ([DIGITS_STRING
                 rangeOfString:[contents substringWithRange:NSMakeRange(i, 1)]]
                .location == NSNotFound) {
                return NO;
            }
        }
        return YES;
    }
    return NO;
}

- (NSString *)initiator {
    return @"";
}

- (NSString *)terminator {
    return @"";
}

- (NSString *)barcode:(NSString *)contents {
    return @"";
}

- (NSString *)completeBarcode:(NSString *)barcode {
    return [NSString
            stringWithFormat:@"%@%@%@", [self initiator], barcode, [self terminator]];
}

- (UIImage *)drawCompleteBarcode:(NSString *)code {
    if (code.length <= 0) {
        return nil;
    }
    
    // Values taken from CIImage generated AVMetadataObjectTypePDF417Code type
    // image
    // Top spacing          = 1.5
    // Bottom spacing       = 2
    // Left & right spacing = 2
    // Height               = 28
    CGSize size = CGSizeMake(code.length + 4, 28);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShouldAntialias(context, false);
    
    //必须设置颜色，否则绘制后会是全黑图片
    [[UIColor whiteColor] setFill];
    [[UIColor blackColor] setStroke];
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    CGContextSetLineWidth(context, 1);
    
    for (int i = 0; i < code.length; i++) {
        NSString *character = [code substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"1"]) {
            CGContextMoveToPoint(context, i + (2 + 1), 1.5);
            CGContextAddLineToPoint(context, i + (2 + 1), size.height - 2);
        }
    }
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIImage *barcode = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return barcode;
}

#pragma mark - CodeGenDelegate
- (UIImage *)genCodeWithContents:(NSString *)contents
   machineReadableCodeObjectType:(NSString *)type {
    if ([self isContentsValid:contents]) {
        return [self
                drawCompleteBarcode:[self completeBarcode:[self barcode:contents]]];
    }
    return nil;
}
@end
#endif