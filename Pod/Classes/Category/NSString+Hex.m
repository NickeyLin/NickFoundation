//
//  NSString+Hex.m
//  CHMobileCommonSDK
//
//  Created by Nick.Lin on 15/10/27.
//  Copyright © 2015年 ChangHong. All rights reserved.
//

#import "NSString+Hex.h"

@implementation NSString (Hex)
+ (NSInteger)binaryStringToInteger:(NSString *)binaryString{
    const char* utf8String = [binaryString UTF8String];
    char* endPtr = NULL;
    NSInteger num = strtol(utf8String, &endPtr, 2);
    return num;
}

+ (NSInteger)hexStringToInteger:(NSString *)hexString{
    const char* utf8String = [hexString UTF8String];
    char* endPtr = NULL;
    NSInteger num = strtol(utf8String, &endPtr, 16);
    return num;
}

+ (NSString *)integerToBinaryString:(NSInteger)value{
    NSMutableString *str = [[NSMutableString alloc] init];
    for(uint64_t numberCopy = value; numberCopy > 0; numberCopy >>= 1){
        [str insertString:((numberCopy & 1) ? @"1" : @"0") atIndex:0];
    }
    return [NSString stringWithString:str];
}

+ (NSString *)integerToHexString:(NSInteger)value{
    return [NSString stringWithFormat:@"%lx", (long)value];
}
@end
