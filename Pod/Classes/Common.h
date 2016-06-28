//
//  Common.h
//  Pods
//
//  Created by Nick.Lin on 16/5/30.
//
//

#ifndef Common_h
#define Common_h

#if DEBUG
#define CHLog(msg, ...)     NSLog(@"\n%@:%d - %s \n%@ \n\n", [[NSString stringWithUTF8String:__FILE__]lastPathComponent], __LINE__, sel_getName(_cmd), [NSString stringWithFormat:(msg), ##__VA_ARGS__]);
#define CHLogT(tag, msg)    CHLog(@"%@\n%@", tag, msg)
#define CHLogO(obj)         CHLog(@"%@", obj)

#else
#define CHLog(msg, ...)     {}
#define CHLogT(tag, msg)    {}
#define CHLogO(obj)         {}
#endif

/* Common */
#import "NLJson.h"

/* Category */
#import "NSDate+Easy.h"
#import "NSString+NormalPath.h"
#import "UIButton+HitTest.h"
#import "NLColor+Easy.h"
#import "UINavigationController+Stack.h"
#import "NLView+Easy.h"

#endif /* Common_h */
