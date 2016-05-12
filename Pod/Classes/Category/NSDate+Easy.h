//
//  NSDate+Easy.h
//  CHMobileCommonSDK
//
//  Created by Nick.Lin on 15/9/29.
//  Copyright © 2015年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Easy)
// 获取实例的年
- (NSInteger)year;
// 获取实例的月
- (NSInteger)month;
// 获取实例的日
- (NSInteger)day;
// 获取实例的小时值
- (NSInteger)hour;
// 获取实例的分钟值
- (NSInteger)minute;
// 获取实例的秒值
- (NSInteger)second;
// 获取实例的星期值
- (NSInteger)weekday;

// 获取实例是否是今天
- (BOOL)isToday;
// 获取实例是否是昨天
- (BOOL)isYesterday;

// 昨天的日期
- (nonnull NSDate *)yesteray;
// 明天的日期
- (nonnull NSDate *)tomorrow;

// 本周第一天的日期
- (nonnull NSDate *)firstDayOfTWeek;
// 本周最后一天的日期
- (nonnull NSDate *)lastDayOfWeek;

// 下周第一天的日期
- (nonnull NSDate *)firstDayOfNextWeek;
// 下周最后一天的日期
- (nonnull NSDate *)lastDayOfNextWeek;

// 上周第一天的日期
- (nonnull NSDate *)firstDayOfPreviousWeek;
// 上周最后一天的日期
- (nonnull NSDate *)lastDayOfPreviousWeek;

// 本月第一天的日期
- (nonnull NSDate *)firstDayOfMonth;
// 本月最后一天的日期
- (nonnull NSDate *)lastDayOfMonth;

// 下月第一天的日期
- (nonnull NSDate *)firstDayOfNextMonth;
// 下月最后一天的日期
- (nonnull NSDate *)lastDayOfNextMonth;

// 上月第一天
- (nonnull NSDate *)firstDayOfPreviousMonth;
// 上月最后一天
- (nonnull NSDate *)lastDayOfPreviousMonth;

// 一周后的日期
- (nonnull NSDate *)nextWeek;
// 一周前的日期
- (nonnull NSDate *)previousWeek;

// 一月后的日期
- (nonnull NSDate *)nextMonth;
// 一月前的日期
- (nonnull NSDate *)previousMonth;


// 根据日期格式和区域获取日期的字符串
- (nullable NSString *)stringWithFormat:(nullable NSString *)format locale:(nullable NSLocale *)locale;
// 根据日期格式获取日期的字符串
- (nullable NSString *)stringWithFormat:(nullable NSString *)format;
// 日期的年月日等各个组成
- (nonnull NSDateComponents *)dateComponents;
// 是否是和date一天
- (BOOL)isSameDay:(nonnull NSDate *)date;
// 除去时间后的日期
- (nonnull NSDate *)dateWithoutTime;

// 根据日期格式和日期字符串获取日期，当前区域
+ (nullable NSDate *)dateFromString:(nonnull NSString *)dateString format:(nullable NSString *)format;

@end

@interface NSString (Date)
- (nullable NSDate *)dateWithFormate:(nullable NSString *)format;
@end
