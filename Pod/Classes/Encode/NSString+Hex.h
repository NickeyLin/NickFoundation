//
//  NSString+Hex.h
//  CHMobileCommonSDK
//
//  Created by Nick.Lin on 15/10/27.
//  Copyright © 2015年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hex)
+ (NSInteger)binaryStringToInteger:(NSString *)binaryString;
+ (NSInteger)hexStringToInteger:(NSString *)hexString;
+ (NSString *)integerToBinaryString:(NSInteger)value;
+ (NSString *)integerToHexString:(NSInteger)value;
@end

@interface NSData (HexString)
- (NSString *)hexString;
+ (NSData *)dataFromHexString:(NSString *)hexString;

@end
