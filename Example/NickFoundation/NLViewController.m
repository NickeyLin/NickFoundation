//
//  NLViewController.m
//  NickFoundation
//
//  Created by Nick.Lin on 04/11/2016.
//  Copyright (c) 2016 Nick.Lin. All rights reserved.
//

#import "NLViewController.h"
#import "UserInfoEntity.h"

@interface NLViewController ()

@end

@implementation NLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NLCoreData *coredata = [NLCoreData instanceWithModelFileName:@"UserInfo" databaseFileName:@"userinfo.sqlite"];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
