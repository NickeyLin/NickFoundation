//
//  CHJsonUtil.h
//  CHMobileCommonSDK
//
//  Created by Nick.Lin on 15/10/8.
//  Copyright © 2015年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol JsonValueProtocol <NSObject>
@required
- (NSString *)jsonStringValue;
- (id)jsonObject;
@end


@interface CHJsonUtil : NSObject
+ (NSString *)jsonObjectToString:(id)jsonObj;
+ (id)stringToJsonObject:(NSString *)str;
@end

@interface NSArray (JsonValue)<JsonValueProtocol>

@end

@interface NSDictionary (JsonValue)<JsonValueProtocol>

@end

@interface NSString (JsonValue)<JsonValueProtocol>
@end

@interface NSData (JsonValue)<JsonValueProtocol>

@end