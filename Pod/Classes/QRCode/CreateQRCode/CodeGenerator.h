//
//  CodeGenerator.h
//  条形码生成器基类及协议
//
//  Created by 王必姣 on 15/10/19.
//  Copyright (c) 2015 ChangHong. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

/**
 *  条形码生成器协议
 */
@protocol CodeGenDelegate <NSObject>

@required

/**
 *  @author Bijiao Wang, 15-10-19 10:58:02
 *
 *  根据传入的内容及码制类型生成相应的条形码
 *
 *  @param contents
 *      条形码所包含的内容
 *  @param  type
 *      码制类型
 *  @return
 *      生成的条形码图片
 */
- (UIImage *)genCodeWithContents:(NSString *)contents
   machineReadableCodeObjectType:(NSString *)type;

@end

/**
 *  并不是所有的code生成器都需要校验位计算。
 *  UPC-E需要校验以便使用有效内容进行编码。
 *  Code39Mod43、Code93和Code128均需要使用它来生成条形码。
 */
@protocol ValidateDelegate <NSObject>

@optional

/**
 *  对传入内容进行校验
 */
- (NSString *)validate:(NSString *)contents;

@end

extern NSString *const DIGITS_STRING;

/**
 *  条形码生成器基类, 封装有条形码验证和图片生成方法.
 */
@interface BaseCodeGenerator : NSObject <CodeGenDelegate>

/**
 *  检测给定的内容是否有效.
 *
 *  @param contents 需要进行编码的内容
 *
 *  @return 给定内容是否有效
 */
- (BOOL)isContentsValid:(NSString *)contents;

/**
 *  条形码起始码，子类需实现自己的方法.
 *
 *  @return 条形码起始码
 */
- (NSString *)initiator;

/**
 *  条形码终止码，子类需实现自己的方法.
 *
 *  @return 条形码终止码
 */
- (NSString *)terminator;

/**
 *  生成的条形码内容，子类需实现自己的方法.
 *
 *  @return
 */
- (NSString *)barcode:(NSString *)contents;

/**
 *  用起始码、终止码以及生成的条形码内容拼装成完整的条形码.
 *
 *  @param barcode 编码后的传入内容
 *
 *  @return 完整的条形码
 */
- (NSString *)completeBarcode:(NSString *)barcode;

/**
 *  绘制条形码
 *
 *  @param code 完整的条形码
 *
 *  @return 生成的条形码图片.
 */
- (UIImage *)drawCompleteBarcode:(NSString *)code;

@end

