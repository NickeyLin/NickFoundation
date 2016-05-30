//
//  NSData+DES.h
//  SH
//
//  Created by Nick.Lin on 16/5/27.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (DES)
- (NSData *)tripleDESEncodeWithKey:(NSData *)key error:(NSError **)error;
- (NSData *)tripleDESDecodeWithKey:(NSData *)key error:(NSError **)error;

@end
