//
//  CWorldAnimation.h
//  CWorldHall_iOS
//
//  Created by 林 建 on 13-4-2.
//  Copyright (c) 2013年 ChangHong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface NLAnimation : NSObject
+(CABasicAnimation *)opacityFadeInWithDuration:(NSTimeInterval)duration;

+(CABasicAnimation *)opacityFadeOutWithDuration:(NSTimeInterval)duration;
+(CABasicAnimation *)opacityForeverWithDuration:(NSTimeInterval)duration;

+ (CABasicAnimation *)opacityForeverWithDuration:(NSTimeInterval)duration startOpacity:(CGFloat)value toOpacity:(CGFloat)toValue;

+(CABasicAnimation *)opacityByTimes:(NSInteger)repeatCount withDuration:(NSTimeInterval)duration;

+(CABasicAnimation *)moveToX:(CGFloat)x withDuration:(NSTimeInterval)duration;

+(CABasicAnimation *)moveToY:(CGFloat)y withDuration:(NSTimeInterval)duration;

+(CABasicAnimation *)scale:(CGFloat)multiple orgin:(CGFloat)orginMultiple withDuration:(NSTimeInterval)duration repeats:(NSInteger)repeatCount;

+(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry withDuration:(NSTimeInterval)duration repeats:(NSInteger)repeatCount;

+(CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path withDuration:(NSTimeInterval)duration repeats:(NSInteger)repeatCount;

+(CABasicAnimation *)moveToPoint:(CGPoint )point duration:(NSTimeInterval)duration;

+(CABasicAnimation *)rotation:(CGFloat)degree withDuration:(NSTimeInterval)duration direction:(NSInteger)direction repeats:(NSInteger)repeatCount;
@end
