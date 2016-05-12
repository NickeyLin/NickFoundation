//
//  NLNSStringHexTest.m
//  NickFoundation
//
//  Created by Nick.Lin on 16/5/12.
//  Copyright © 2016年 Nick.Lin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Hex.h"

@interface NLNSStringHexTest : XCTestCase

@end

@implementation NLNSStringHexTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testHexToInteger{
    NSString *hexString = @"134F"; // 4943
    const NSInteger right = 4943;
    
    NSInteger result = [NSString hexStringToInteger:hexString];
    XCTAssertTrue(result == right, @"%@", @(result));
    
    hexString = @"0x134F";
    XCTAssertTrue(result == right, @"%@", @(result));

    hexString = @"#134F";
    XCTAssertTrue(result == right, @"%@", @(result));
    
    hexString = @"134fi";
    XCTAssertTrue(result == right, @"%@", @(result));
}

@end
