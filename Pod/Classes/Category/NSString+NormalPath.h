//
//  NSString+NormalPath.h
//  Pods
//
//  Created by Nick.Lin on 16/4/21.
//
//

#import <Foundation/Foundation.h>

@interface NSString (NormalPath)
/**
 *  /Documents
 *
 *  @return path of /Documents
 */
+ (NSString *)documentDirectory;

/**
 *  /Library
 *
 *  @return path of /Library
 */
+ (NSString *)libraryDirectory;

/**
 *  /Temp
 *
 *  @return path of /Temp
 */
+ (NSString *)tempDirectory;

/**
 *  /Documents/Image
 *
 *  @return path of /Documents/Image
 */
+ (NSString *)imageDirectory;

/**
 *  /Documents/UserFiles
 *
 *  @return path of /Documents/UserFiles
 */
+ (NSString *)userFilesDirectory;

/**
 *  /Documents/Upzip
 *
 *  @return path of /Documents/Upzip
 */
+ (NSString *)unzipDirectory;

/**
 *  /Documents/HTMLS
 *
 *  @return path of /Documents/HTMLS
 */
+ (NSString *)htmlsDirectory;

/**
 *  /Documents/Download/archive
 *
 *  @return path of /Documents/Download/archive
 */
+ (NSString *)downloadDirectory;
@end
