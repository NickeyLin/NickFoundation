//
//  CWorldAnimation.m
//  CWorldHall_iOS
//
//  Created by 林 建 on 13-4-2.
//  Copyright (c) 2013年 ChangHong. All rights reserved.
//

#import "NLAnimation.h"
@implementation NLAnimation
//淡入
+ (CABasicAnimation *)opacityFadeInWithDuration:(NSTimeInterval)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    animation.autoreverses = YES;
    animation.duration = duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

//淡出
+(CABasicAnimation *)opacityFadeOutWithDuration:(NSTimeInterval)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:.0];
    animation.autoreverses = YES;
    animation.duration=duration;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

//永久闪烁的动画
+(CABasicAnimation *)opacityForeverWithDuration:(NSTimeInterval)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.0];
    animation.autoreverses = YES;
    animation.duration=duration;
    animation.repeatCount=FLT_MAX;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

+ (CABasicAnimation *)opacityForeverWithDuration:(NSTimeInterval)duration startOpacity:(CGFloat)value toOpacity:(CGFloat)toValue{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:value];
    animation.toValue = [NSNumber numberWithFloat:toValue];
    animation.autoreverses = YES;
    animation.duration=duration;
    animation.repeatCount=FLT_MAX;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

//有闪烁次数的动画
+(CABasicAnimation *)opacityByTimes:(NSInteger)repeatCount withDuration:(NSTimeInterval)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.4];
    animation.repeatCount=repeatCount;
    animation.duration=duration;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses = YES;
    return  animation;
}

//横向移动
+(CABasicAnimation *)moveToX:(CGFloat)x withDuration:(NSTimeInterval)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.toValue=@(x);
    animation.duration=duration;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

//纵向移动
+(CABasicAnimation *)moveToY:(CGFloat)y withDuration:(NSTimeInterval)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.toValue=@(y);
    animation.duration=duration;
    animation.removedOnCompletion=NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

//缩放
+ (CABasicAnimation *)scale:(CGFloat)multiple orgin:(CGFloat)orginMultiple withDuration:(NSTimeInterval)duration repeats:(NSInteger)repeatCount{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=@(orginMultiple);
    animation.toValue=@(multiple);
    animation.duration=duration;
    animation.autoreverses = YES;
    animation.repeatCount=repeatCount;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

//组合动画
+ (CAAnimationGroup *)groupAnimation:(NSArray *)animationAry withDuration:(NSTimeInterval)duration repeats:(NSInteger)repeatCount{
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations=animationAry;
    animation.duration=duration;
    animation.repeatCount=repeatCount;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}

//路径动画
+ (CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path withDuration:(NSTimeInterval)duration repeats:(NSInteger)repeatCount{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path=path;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses=NO;
    animation.duration=duration;
    animation.repeatCount=repeatCount;
    return animation;
}

//点移动
+ (CABasicAnimation *)moveToPoint:(CGPoint)point duration:(NSTimeInterval)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation.toValue = [NSValue valueWithCGPoint:point];
    animation.removedOnCompletion=NO;
    animation.duration = duration;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}


//旋转
+ (CABasicAnimation *)rotation:(CGFloat)degree withDuration:(NSTimeInterval)duration direction:(NSInteger)direction repeats:(NSInteger)repeatCount{
    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, 0,direction);
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration= duration;
    animation.autoreverses= NO;
    animation.cumulative= YES;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.repeatCount= repeatCount;
    animation.delegate= self;
    
    return animation;
}

@end
