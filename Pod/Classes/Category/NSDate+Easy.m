//
//  NSDate+Easy.m
//  CHMobileCommonSDK
//
//  Created by Nick.Lin on 15/9/29.
//  Copyright © 2015年 ChangHong. All rights reserved.
//

#import "NSDate+Easy.h"

@implementation NSDate (Easy)
- (NSString *)stringWithFormat:(NSString *)format{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

- (NSString *)stringWithDefaultFormat{
    return [self stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}
@end

@implementation NSString (Date)

- (NSDate *)dateWithFormate:(NSString *)format{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:format];
    return [formatter dateFromString:self];
}

- (NSDate *)dateWithDefaultFormat{
    return [self dateWithFormate:@"yyyy-MM-dd HH:mm:ss"];
}
@end
