//
//  UIView+Easy.m
//  CHMobileUISDK
//
//  Created by Nick.Lin on 15/9/29.
//  Copyright © 2015年 ChangHong. All rights reserved.
//

#import "NLView+Easy.h"

@implementation NLView (Easy)

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height{
    return self.frame.size.height;
}


- (void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)right{
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)bottom{
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX{
#if TARGET_OS_IOS
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
#else
    CGFloat currentCenterX = self.x + self.width / 2;
    CGFloat offsetX = centerX - currentCenterX;
    CGRect frame = CGRectOffset(self.frame, offsetX, 0);
    self.frame = frame;
#endif
    
    
}

- (CGFloat)centerX{
#if TARGET_OS_IOS

    return self.center.x;
#else
    
    return self.x + self.width / 2;
#endif
}

- (void)setCenterY:(CGFloat)centerY{
#if TARGET_OS_IOS

    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
#else
    CGFloat currentCenterY = self.y + self.height / 2;
    CGFloat offsetY = centerY - currentCenterY;
    CGRect frame = CGRectOffset(self.frame, 0, offsetY);
    self.frame = frame;
#endif
}

- (CGFloat)centerY{
#if TARGET_OS_IOS
    return self.center.y;
#else
    return self.y + self.height / 2;
#endif
}

#if TARGET_OS_IOS
- (id)firstResponder{
    if ([self isFirstResponder]) {
        return self;
    }
    id result = nil;
    for (UIView *subView in self.subviews) {
        result = [subView firstResponder];
        if (result) {
            return result;
        }
    }
    return result;
}
#endif
@end
