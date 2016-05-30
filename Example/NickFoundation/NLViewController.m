//
//  NLViewController.m
//  NickFoundation
//
//  Created by Nick.Lin on 04/11/2016.
//  Copyright (c) 2016 Nick.Lin. All rights reserved.
//

#import "NLViewController.h"
#import "UserInfoEntity.h"
#import "NLScanQRUtil.h"
#import "NLCoreData.h"
#import <NickFoundation/Common.h>
#import <NickFoundation/NLCoreData.h>
#import <NickFoundation/NLScanQRUtil.h>


//#import "NLScanQRUtil.h"

@interface NLViewController ()

@end

@implementation NLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NLCoreData *coredata = [NLCoreData instanceWithModelFileName:@"UserInfo" databaseFileName:@"userinfo.sqlite"];
    self.view.backgroundColor = [UIColor colorWithRGBHex:0x999999];
//    UserInfoEntity *entity = [UserInfoEntity insertNewItemInCoreData:coredata fillContent:^(id  _Nullable item) {
//        [(UserInfoEntity *)item setUName:@"nick"];
//        
//    }];
//    BOOL success = [entity saveToContext:coredata];
//    NSLog(@"success: %@, \npath: %@", @(success), coredata.dataRootPath);
    NSLog(@"%@", @([UserInfoEntity itemsInCoreData:coredata].count));
    
//    UserInfoEntity *firstNick = [[UserInfoEntity itemsInCoreData:coredata] firstObject];
//    [firstNick removeFrom:coredata];
//    [coredata saveContext];
    NSLog(@"%@", @([UserInfoEntity itemsInCoreData:coredata].count));
    NSLog(@"%@", [UserInfoEntity itemsInCoreData:coredata withFormat:@"uName==\"nick\""]);
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [NLScanQRUtil presentQRScanInViewController:self Complete:^(NSString *result, NSError *error) {
//        NSLog(@"%@, %@", result, error);
//    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
