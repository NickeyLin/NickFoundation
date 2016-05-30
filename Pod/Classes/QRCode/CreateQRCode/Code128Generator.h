//
//  Code128Generator.h
//  Code128编码的条形码
//
//  Created by 王必姣 on 15/10/19.
//  Copyright (c) 2015 ChangHong. All rights reserved.
//

#import "CodeGenerator.h"

#if TARGET_OS_IOS

typedef NS_ENUM(NSUInteger, Code128GeneratorCodeTable) {
    Code128GeneratorCodeTableAuto = 0,
    Code128GeneratorCodeTableA = 1,
    Code128GeneratorCodeTableB = 2,
    Code128GeneratorCodeTableC = 3
};


@interface Code128Generator : BaseCodeGenerator <ValidateDelegate>

@property(nonatomic) Code128GeneratorCodeTable codeTable;

/**
 *  根据传入内容初始化.
 *
 *  @param contents 需要进行编码的内容
 *
 *  @return
 */
- (id)initWithContents:(NSString *)contents;
/**
 *  @author Bijiao Wang, 15-10-14 09:58:16
 *
 *  根据传入的信息和图片宽高生成条形码图片
 *
 *  @param code
 *      包含的信息
 *  @param  width
 *      图片宽度
 *  @param  height
 *      图片高度
 *  @return  生成的条形码图片
 */
- (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height codeType:(NSInteger)codeType;

/**
 *  @author Bijiao Wang, 15-10-14 10:55:11
 *
 *  根据传入的信息和图片宽高生成二维码图片
 *
 *  @param code
 *      包含的信息
 *  @param  width
 *      图片宽度
 *  @param  height
 *      图片高度
 *  @return  生成的二维码图片
 */
- (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height codeType:(NSInteger)codeType;
/**
 *  @author Bijiao Wang, 15-10-14 10:38:36
 *
 *  保存条形码或二维码图片至image目录，并返回对应的图片路径
 *
 *  @param image
 *      生成的条形码或二维码图片
 *  @param  imgName
 *      保存的图片名称
 *  @return  图片路径
 */

- (NSString *)saveSandBoxImageAtPath:(UIImage *)image imgName:(NSString *)imgName;
@end
#endif