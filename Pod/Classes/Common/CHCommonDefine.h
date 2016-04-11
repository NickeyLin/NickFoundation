//
//  CHCommonDefine.h
//  CHMobileCommonSDK
//
//  Created by Nick.Lin on 15/11/27.
//  Copyright © 2015年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>

#if DEBUG
#define CHLog(msg, ...)     NSLog(@"\n%@:%d - %s \n%@ \n\n", [[NSString stringWithUTF8String:__FILE__]lastPathComponent], __LINE__, sel_getName(_cmd), [NSString stringWithFormat:(msg), ##__VA_ARGS__]);
#define CHLogT(tag, msg)    CHLog(@"%@\n%@", tag, msg)
#define CHLogO(obj)         CHLog(@"%@", obj)

#else
#define CHLog(msg, ...)     {}
#define CHLogT(tag, msg)    {}
#define CHLogO(obj)         {}
#endif

// 这个类暂时没得什么用
@interface CHCommonDefine : NSObject

@end
