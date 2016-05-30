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
    if ([hexString hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }else if ([hexString hasPrefix:@"#"]){
        hexString = [hexString substringFromIndex:1];
    }
    
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


@implementation NSData (HexString)
- (NSString *)hexString{
    return [NSData hexStringFromData:self];
}
+ (NSData *)dataFromHexString:(NSString *)hexString{
    if (hexString.length % 2 != 0) {
        return nil;
    }
    NSMutableData *data = [NSMutableData data];
    
    for (int i = 0; i < hexString.length; i += 2) {
        NSString *sub = [hexString substringWithRange:NSMakeRange(i, 2)];
        
        NSScanner *scanner = [NSScanner scannerWithString:sub];
        
        unsigned hexNum;
        if (![scanner scanHexInt:&hexNum]) return nil;
        char b = hexNum;
        [data appendBytes:&b length:1];
    }
    return data;
}

#pragma mark - private
+ (NSString *)hexStringFromData:(NSData *)data{
    return [self hexStringFromChar:[data bytes] length:data.length];
}
+ (NSString *)hexStringFromChar:(char *)inChar length:(int)length{
    //    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *myD = [NSData dataWithBytes:inChar length:length];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}
@end