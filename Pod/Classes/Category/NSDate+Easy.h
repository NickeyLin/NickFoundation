//
//  NSDate+Easy.h
//  CHMobileCommonSDK
//
//  Created by Nick.Lin on 15/9/29.
//  Copyright © 2015年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Easy)
- (nullable NSString *)stringWithFormat:(nullable NSString *)format;
- (nullable NSString *)stringWithDefaultFormat;
@end

@interface NSString (Date)
- (nullable NSDate *)dateWithFormate:(nullable NSString *)format;
- (nullable NSDate *)dateWithDefaultFormat;
@end
