//
//  UIButton+HitTest.h
//  CHMobileUISDK
//
//  Created by Nick.Lin on 15/9/29.
//  Copyright © 2015年 ChangHong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (HitTest)
// 热点区域边界, 可扩大按钮相应区域
@property (nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;
@end
