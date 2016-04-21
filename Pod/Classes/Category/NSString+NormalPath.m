//
//  NSString+NormalPath.m
//  Pods
//
//  Created by Nick.Lin on 16/4/21.
//
//

#import "NSString+NormalPath.h"

@implementation NSString (NormalPath)
+ (NSString *)documentDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)libraryDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)tempDirectory{
    return NSTemporaryDirectory();
}

+ (NSString *)imageDirectory{
    return [[self documentDirectory] stringByAppendingPathComponent:@"Image"];
}

+ (NSString *)userFilesDirectory{
    return [[self documentDirectory] stringByAppendingPathComponent:@"UserFiles"];
}

+ (NSString *)unzipDirectory{
    return [[self documentDirectory] stringByAppendingPathComponent:@"Upzip"];
}

+ (NSString *)htmlsDirectory{
    return [[self documentDirectory] stringByAppendingPathComponent:@"HTMLS"];
}

+ (NSString *)downloadDirectory{
    return [[self documentDirectory] stringByAppendingPathComponent:@"Download/archive"];
}
@end
