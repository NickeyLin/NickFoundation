//
//  UINavigationController+Stack.m
//  CHMobileCommonSDK
//
//  Created by Nick.Lin on 15/9/28.
//  Copyright © 2015年 ChangHong. All rights reserved.
//

#import "UINavigationController+Stack.h"

@implementation UINavigationController (Stack)
- (NSArray *)popViewControllersByBlock:(BOOL (^)(UIViewController *vc, NSInteger idx, BOOL *stop))block animated:(BOOL)animated{
    if (!block) {
        return nil;
    }
    
    NSMutableArray *viewControllers = [self.viewControllers mutableCopy];
    NSMutableArray *tempArray = [NSMutableArray array];
    [viewControllers enumerateObjectsUsingBlock:^(id  obj, NSUInteger idx, BOOL * stop) {
        BOOL result = block(obj, idx, stop);
        
        if (result) {
            [tempArray addObject:obj];
        }
    }];
    [viewControllers removeObjectsInArray:tempArray];
    [self setViewControllers:viewControllers animated:animated];
    return tempArray;
}

- (void)pushAnExpectedViewControllerToTopByBlock:( BOOL (^)(UIViewController * vc, NSInteger idx))block ifNotExist:(UIViewController *(^)(void))createNewVCBlock animated:(BOOL)animated{
    if (!block) {
        return;
    }
    __block UIViewController *vc = nil;
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController * obj, NSUInteger idx, BOOL * stop) {
        BOOL result = block(obj, idx);
        if (result) {
            vc = obj;
            *stop = YES;
        }
    }];
    if (!vc) {
        if (createNewVCBlock) {
            vc = createNewVCBlock();
        }
        if (!vc) {
            return;
        }else{
            [self pushViewController:vc animated:animated];
        }
        return;
    }
    NSMutableArray *temp = [self.viewControllers mutableCopy];
    
    [temp removeObject:vc];
    [self setViewControllers:temp];
    [self pushViewController:vc animated:animated];
}

- (NSArray *)popToViewControllerByBlock:(BOOL (^)(UIViewController *, NSInteger))block animated:(BOOL)animated{
    if (!block) {
        return nil;
    }
    
    __block UIViewController *vc = nil;
    [self.viewControllers enumerateObjectsUsingBlock:^( UIViewController *  obj, NSUInteger idx, BOOL *  stop) {
        BOOL result = block(obj, idx);
        if (result) {
            vc = obj;
            *stop = YES;
        }
    }];
    NSArray *result = nil;
    if (vc) {
        result = [self popToViewController:vc animated:animated];
    }
    return result;
}

- (void)pushViewControllers:(NSArray *)vcs atIndex:(NSInteger)index animated:(BOOL)animated{
    if (!vcs || ![vcs isKindOfClass:[NSArray class]] || vcs.count <= 0) {
        return;
    }
    NSMutableArray *viewControllersCopy = [self.viewControllers mutableCopy];
    if (!viewControllersCopy || viewControllersCopy.count <= 0) {
        return;
    }
    
    if (index == 0) {
        [self setViewControllers:vcs animated:animated];
    }else if (index < viewControllersCopy.count - 1){
        [viewControllersCopy removeObjectsInRange:NSMakeRange(index, viewControllersCopy.count - index)];
        [viewControllersCopy addObjectsFromArray:vcs];
        [self setViewControllers:viewControllersCopy animated:animated];
    }else{
        [viewControllersCopy addObjectsFromArray:vcs];
        [self setViewControllers:viewControllersCopy animated:animated];
    }
}

@end
