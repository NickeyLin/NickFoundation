//
//  UINavigationController+Stack.h
//  CHMobileCommonSDK
//
//  Created by Nick.Lin on 15/9/28.
//  Copyright © 2015年 ChangHong. All rights reserved.
//

#if TARGET_OS_IOS

#import <UIKit/UIKit.h>


@interface UINavigationController (Stack)

/** 关闭视图控制器，通过block遍历UINavigationController下的所有视图控制器，该block可以为空，当block为空时，将不做任何操作。
 该block有三个参数：
 vc
 数组里的视图控制器
 idx
 该视图控制器在数组里的索引
 stop
 BOOL类型的指针，将stop设置为YES即终止遍历
 该block的返回值为Boolean类型，返回YES，表示该试图控制器是需要关闭的视图控制器
 */
- (NSArray *)popViewControllersByBlock:(BOOL (^)(UIViewController * vc, NSInteger idx, BOOL * stop))block animated:(BOOL)animated;

/**
 *  @author Nick
 *
 *  pop到指定的viewController，通过block遍历UINavigationController下的所有视图控制器，该block可以为空，当block为空时，将不做任何操作。
 *
 *  @param block    返回YES，表示要pop到该视图控制器
 *  @param animated 是否需要动画的标志位
 *
 *  @return 移除导航堆栈的视图控制器数组
 */
- (NSArray *)popToViewControllerByBlock:(BOOL (^)(UIViewController *vc, NSInteger idx))block animated:(BOOL)animated;


/**
 *  @author Nick
 *
 *  通过block，将堆栈中的某一个viewController push到栈顶
 *
 *  @param block
 *  @param animated
 *  @param complete 
 */
- (void)pushAnExpectedViewControllerToTopByBlock:( BOOL (^)(UIViewController * vc, NSInteger idx))block ifNotExist:(UIViewController *(^)(void))createNewVCBlock animated:(BOOL)animated;

/**
 *  @author Nick
 *
 *  将视图控制器数组，push到导航堆栈指定位置
 *
 *  @param vcs      要push的视图控制器数组
 *  @param index
 *  @param animated 
 */
- (void)pushViewControllers:(NSArray *)vcs atIndex:(NSInteger)index animated:(BOOL)animated;

@end

#endif