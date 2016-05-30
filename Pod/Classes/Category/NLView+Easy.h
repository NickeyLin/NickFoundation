//
//  UIView+Easy.h
//  CHMobileUISDK
//
//  Created by Nick.Lin on 15/9/29.
//  Copyright © 2015年 ChangHong. All rights reserved.
//

#ifndef NLView
#if TARGET_OS_IOS
#define NLView UIView
#import <UIKit/UIKit.h>

#else
#define NLView NSView

#endif
#endif


@interface NLView (Easy)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;


@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

#if TARGET_OS_IOS
- (id)firstResponder;
#endif
@end
