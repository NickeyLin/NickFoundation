//
//  UserInfoEntity+CoreDataProperties.h
//  NickFoundation
//
//  Created by Nick.Lin on 16/4/20.
//  Copyright © 2016年 Nick.Lin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserInfoEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *uID;
@property (nullable, nonatomic, retain) NSString *uName;
@property (nullable, nonatomic, retain) NSNumber *uAge;
@property (nullable, nonatomic, retain) NSDecimalNumber *uColor;

@end

NS_ASSUME_NONNULL_END
