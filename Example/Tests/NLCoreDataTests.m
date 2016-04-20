//
//  NLCoreDataTests.m
//  NickFoundation
//
//  Created by Nick.Lin on 16/4/20.
//  Copyright © 2016年 Nick.Lin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserInfoEntity.h"

@interface NLCoreDataTests : XCTestCase
@property (nonatomic, strong) NLCoreData *cda;
@end

@implementation NLCoreDataTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.cda = [NLCoreData instanceWithModelFileName:@"UserInfo" databaseFileName:@"userinfo.sqlite"];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
- (void)testInsertItem{
    NSArray *itemsBefore = [UserInfoEntity itemsInCoreData:_cda];

    UserInfoEntity *userEntity = [UserInfoEntity insertNewItemInCoreData:_cda];
    userEntity.uName = @"Nickey";
    [userEntity saveToContext:_cda];
    
    NSArray *itemsAfter = [UserInfoEntity itemsInCoreData:_cda];
    XCTAssertTrue((itemsAfter.count - itemsBefore.count) == 1);
    NSLog(@"before:\n%@\nafter:\n%@", itemsBefore, itemsAfter);
}
- (void)testInsertItemThenFillDataByBlock{
    NSArray *itemsBefore = [UserInfoEntity itemsInCoreData:_cda];
    
    UserInfoEntity *userEntity = [UserInfoEntity insertNewItemInCoreData:_cda fillContent:^(id  _Nullable item) {
        ((UserInfoEntity *)item).uName = @"Nickey.Lean";
    }];
    [userEntity saveToContext:_cda];
    
    NSArray *itemsAfter = [UserInfoEntity itemsInCoreData:_cda];
    XCTAssertTrue((itemsAfter.count - itemsBefore.count) == 1);
    NSLog(@"before:\n%@\nafter:\n%@", itemsBefore, itemsAfter);
}
- (void)testQueryAllItems{
    NSArray *items = [UserInfoEntity itemsInCoreData:_cda];
    XCTAssertNotNil(items);
    NSLog(@"%@", items);
}
- (void)testQueryByFmt{
    NSArray *items = [UserInfoEntity itemsInCoreData:_cda withFormat:@"uName=='nick'"];
    XCTAssertNotNil(items);
    NSLog(@"%@", items);
}
- (void)testDeleteItem{
    NSArray *itemsBefore = [UserInfoEntity itemsInCoreData:_cda];

    UserInfoEntity *userEntity = [[UserInfoEntity itemsInCoreData:_cda withFormat:@"uName=='Nickey.Lean'"] firstObject];
    [userEntity removeFrom:_cda];
    NSArray *itemsAfter = [UserInfoEntity itemsInCoreData:_cda];
    XCTAssertTrue((itemsBefore.count - itemsAfter.count) == 1);
}
- (void)testUpdateItem{
    UserInfoEntity *userEntity = [[UserInfoEntity itemsInCoreData:_cda] firstObject];
    userEntity.uName = @"another name";
    userEntity.uAge = @(24);
    BOOL success = [userEntity saveToContext:_cda];
    XCTAssertTrue(success);
}

@end
