//
//  CHJsonUtil.m
//  CHMobileCommonSDK
//
//  Created by Nick.Lin on 15/10/8.
//  Copyright © 2015年 ChangHong. All rights reserved.
//

#import "CHJsonUtil.h"
#import "CHCommonDefine.h"

@implementation CHJsonUtil
+ (NSString *)jsonObjectToString:(id)jsonObj{
    if (!jsonObj || (![jsonObj isKindOfClass:[NSArray class]] && ![jsonObj isKindOfClass:[NSDictionary class]])) {
        CHLog(@"param is not a valid json-object");
        return nil;
    }
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonObj options:0 error:&error];
    if (error) {
        CHLog(@"dict to json fail: %@", error);
        return nil;
    }
    NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}

+ (id)stringToJsonObject:(NSString *)str{
    if (!str) {
        CHLog(@"string is null");
        return nil;
    }
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        CHLog(@"string to json-obj fail: %@", error);
        return nil;
    }
    return result;
}
@end

@implementation NSDictionary (JsonValue)

- (NSString *)jsonStringValue{
    return [CHJsonUtil jsonObjectToString:self];
}
- (id)jsonObject{
    return self;
}
@end

@implementation NSArray (JsonValue)

- (NSString *)jsonStringValue{
    return [CHJsonUtil jsonObjectToString:self];
}
- (id)jsonObject{
    return self;
}
@end

@implementation NSString (JsonValue)

- (id)jsonObject{
    return [CHJsonUtil stringToJsonObject:self];
}
- (NSString *)jsonStringValue{
    return self;
}
@end

@implementation NSData (JsonValue)

- (id)jsonObject{
    NSError *error;
    id result = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        CHLog(@"string to json-obj fail: %@", error);
        return nil;
    }
    return result;
}

- (NSString *)jsonStringValue{
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}
@end