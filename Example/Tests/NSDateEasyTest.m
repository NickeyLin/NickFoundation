//
//  NSDateEasyTest.m
//  NickFoundation
//
//  Created by Nick.Lin on 16/5/12.
//  Copyright © 2016年 Nick.Lin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+Easy.h"

@interface NSDateEasyTest : XCTestCase
@property (nonatomic, strong) NSDate *date;
@end

@implementation NSDateEasyTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.date = [NSDate date];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testYear{

    XCTAssertTrue(self.date.year == 2016);
}
- (void)testMonth {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertTrue(self.date.month == 5);
}

- (void)testDayWeekday{
    XCTAssertTrue(self.date.day == 12);
    XCTAssertTrue(self.date.weekday == 5, @"weekday:%ld,  date:%@", (long)self.date.weekday, self.date);
}

- (void)testHourMinute{
    XCTAssertTrue(self.date.hour == 16);
//    XCTAssertTrue(self.date.minute == 11);
}

- (void)testIsTodayOrIsYesterday{
    XCTAssertTrue(self.date.isToday);
    XCTAssertFalse(self.date.isYesterday);
}
- (void)testYesterDay{
    NSDate *yesterday = [self.date yesteray];
    XCTAssertTrue(yesterday.day == 11 && yesterday.month == 5 && yesterday.year == 2016);
}
- (void)testTomorrow{
    NSDate *tomorrow = [self.date tomorrow];
    XCTAssertTrue(tomorrow.day == 13 && tomorrow.month == 5 && tomorrow.year == 2016);
}
- (void)testFisrtDayOfThisWeek{
    NSDate *firstDayOfWeek = [self.date firstDayOfTWeek];
    XCTAssertTrue(firstDayOfWeek.day == 8 && firstDayOfWeek.month == 5 && firstDayOfWeek.year == 2016);
}

- (void)testLastDayOfThisWeek{
    NSDate *lastDayOfWeek = [self.date lastDayOfWeek];
    XCTAssertTrue(lastDayOfWeek.day == 14 && lastDayOfWeek.month == 5 && lastDayOfWeek.year == 2016, @"%@, %@, %@", @(lastDayOfWeek.day), @(lastDayOfWeek.month), @(lastDayOfWeek.year));
}
- (void)testFisrtDayOfNextWeek{
    NSDate *firstDayOfWeek = [self.date firstDayOfNextWeek];
    XCTAssertTrue(firstDayOfWeek.day == 15 && firstDayOfWeek.month == 5 && firstDayOfWeek.year == 2016);
}

- (void)testLastDayOfNextWeek{
    NSDate *lastDayOfWeek = [self.date lastDayOfNextWeek];
    XCTAssertTrue(lastDayOfWeek.day == 21 && lastDayOfWeek.month == 5 && lastDayOfWeek.year == 2016);
}
- (void)testFisrtDayOfThisMonth{
    NSDate *firstDayOfWeek = [self.date firstDayOfMonth];
    XCTAssertTrue(firstDayOfWeek.day == 1 && firstDayOfWeek.month == 5 && firstDayOfWeek.year == 2016);
}

- (void)testLastDayOfThisMonth{
    NSDate *lastDayOfWeek = [self.date lastDayOfMonth];
    XCTAssertTrue(lastDayOfWeek.day == 31 && lastDayOfWeek.month == 5 && lastDayOfWeek.year == 2016, @"%@, %@, %@", @(lastDayOfWeek.day), @(lastDayOfWeek.month), @(lastDayOfWeek.year));
}

- (void)testFisrtDayOfNextMonth{
    NSDate *firstDayOfWeek = [self.date firstDayOfNextMonth];
    XCTAssertTrue(firstDayOfWeek.day == 1 && firstDayOfWeek.month == 6 && firstDayOfWeek.year == 2016);
}

- (void)testLastDayOfNextMonth{
    NSDate *lastDayOfWeek = [self.date lastDayOfNextMonth];
    XCTAssertTrue(lastDayOfWeek.day == 30 && lastDayOfWeek.month == 6 && lastDayOfWeek.year == 2016,  @"%@, %@, %@", @(lastDayOfWeek.day), @(lastDayOfWeek.month), @(lastDayOfWeek.year));
}

- (void)testFisrtDayOfPreviousMonth{
    NSDate *firstDayOfWeek = [self.date firstDayOfPreviousMonth];
    XCTAssertTrue(firstDayOfWeek.day == 1 && firstDayOfWeek.month == 4 && firstDayOfWeek.year == 2016);
}

- (void)testLastDayOfPreviousMonth{
    NSDate *lastDayOfWeek = [self.date lastDayOfPreviousMonth];
    XCTAssertTrue(lastDayOfWeek.day == 30 && lastDayOfWeek.month == 4 && lastDayOfWeek.year == 2016,  @"%@, %@, %@", @(lastDayOfWeek.day), @(lastDayOfWeek.month), @(lastDayOfWeek.year));
}
- (void)testFisrtDayOfPreviousWeek{
    NSDate *firstDayOfWeek = [self.date firstDayOfPreviousWeek];
    XCTAssertTrue(firstDayOfWeek.day == 1 && firstDayOfWeek.month == 5 && firstDayOfWeek.year == 2016);
}

- (void)testLastDayOfPreviousWeek{
    NSDate *lastDayOfWeek = [self.date lastDayOfPreviousWeek];
    XCTAssertTrue(lastDayOfWeek.day == 7 && lastDayOfWeek.month == 5 && lastDayOfWeek.year == 2016,  @"%@, %@, %@", @(lastDayOfWeek.day), @(lastDayOfWeek.month), @(lastDayOfWeek.year));
}

- (void)testPreviousAndNextWeekAndMonth{
    NSDate *tempDate = [self.date previousWeek];
    XCTAssertTrue(tempDate.day == 5 && tempDate.month == 5 && tempDate.year == 2016,  @"%@, %@, %@", @(tempDate.day), @(tempDate.month), @(tempDate.year));
    
    tempDate = [self.date nextWeek];
    XCTAssertTrue(tempDate.day == 19 && tempDate.month == 5 && tempDate.year == 2016,  @"%@, %@, %@", @(tempDate.day), @(tempDate.month), @(tempDate.year));
    
    tempDate = [self.date previousMonth];
    XCTAssertTrue(tempDate.day == 12 && tempDate.month == 4 && tempDate.year == 2016,  @"%@, %@, %@", @(tempDate.day), @(tempDate.month), @(tempDate.year));
    
    tempDate = [self.date nextMonth];
    XCTAssertTrue(tempDate.day == 12 && tempDate.month == 6 && tempDate.year == 2016,  @"%@, %@, %@", @(tempDate.day), @(tempDate.month), @(tempDate.year));
}

- (void)testStringFromDate{
    NSString *prefix = @"2016-05-12 16:04";
    NSString *dateString = [self.date stringWithFormat:nil];
    NSLog(@"%@", dateString);
    XCTAssertTrue([dateString hasPrefix:prefix], @"%@", dateString);
    
    dateString = [self.date stringWithFormat:@"yyyy/MM/dd HH:mm:ss"];
    XCTAssertTrue([dateString hasPrefix:@"2016/05/12 16:04"], @"%@", dateString);
}


@end
