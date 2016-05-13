//
//  Code128Generator.m
//  Code128编码的条形码
//
//  Created by 王必姣 on 15/10/19.
//  Copyright (c) 2015 ChangHong. All rights reserved.
//

#import "Code128Generator.h"
//#import "CodeGenerator.h"

static NSString *const CODE128_ALPHABET_STRING =
@" !\"#$%&'()*+,-./"
@"0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_'"
@"abcdefghijklmnopqrstuvwxyz{|}~";

static NSString *const CODE128_CHARACTER_ENCODINGS[107] = {
    @"11011001100", @"11001101100", @"11001100110", @"10010011000",
    @"10010001100", @"10001001100", @"10011001000", @"10011000100",
    @"10001100100", @"11001001000", @"11001000100", @"11000100100",
    @"10110011100", @"10011011100", @"10011001110", @"10111001100",
    @"10011101100", @"10011100110", @"11001110010", @"11001011100",
    @"11001001110", @"11011100100", @"11001110100", @"11101101110",
    @"11101001100", @"11100101100", @"11100100110", @"11101100100",
    @"11100110100", @"11100110010", @"11011011000", @"11011000110",
    @"11000110110", @"10100011000", @"10001011000", @"10001000110",
    @"10110001000", @"10001101000", @"10001100010", @"11010001000",
    @"11000101000", @"11000100010", @"10110111000", @"10110001110",
    @"10001101110", @"10111011000", @"10111000110", @"10001110110",
    @"11101110110", @"11010001110", @"11000101110", @"11011101000",
    @"11011100010", @"11011101110", @"11101011000", @"11101000110",
    @"11100010110", @"11101101000", @"11101100010", @"11100011010",
    @"11101111010", @"11001000010", @"11110001010", @"10100110000", // 64
    // Visible character encoding for code table A ended.
    @"10100001100", @"10010110000", @"10010000110", @"10000101100",
    @"10000100110", @"10110010000", @"10110000100", @"10011010000",
    @"10011000010", @"10000110100", @"10000110010", @"11000010010",
    @"11001010000", @"11110111010", @"11000010100", @"10001111010",
    @"10100111100", @"10010111100", @"10010011110", @"10111100100",
    @"10011110100", @"10011110010", @"11110100100", @"11110010100",
    @"11110010010", @"11011011110", @"11011110110", @"11110110110",
    @"10101111000", @"10100011110", @"10001011110",
    // Visible character encoding for code table B ended.
    @"10111101000", @"10111100010", @"11110101000", @"11110100010",
    @"10111011110",                 // to C from A, B (size - 8)
    @"10111101110",                 // to B from A, C (size - 7)
    @"11101011110",                 // to A from B, C (size - 6)
    @"11110101110", @"11010000100", // START A (size - 4)
    @"11010010000",                 // START B (size - 3)
    @"11010011100",                 // START C (size - 2)
    @"11000111010"                  // STOP    (size - 1)
};

@interface AutoCodeTable : NSObject

@property(nonatomic) Code128GeneratorCodeTable startCodeTable;

@property(nonatomic) NSMutableArray *sequence;

@end


@implementation AutoCodeTable

- (NSMutableArray *)sequence {
    if (!_sequence) {
        _sequence = [[NSMutableArray alloc] init];
    }
    return _sequence;
}

@end


@interface Code128Generator () <ValidateDelegate>


@property(nonatomic) NSUInteger codeTableSize;

@property(nonatomic, strong) AutoCodeTable *autoCodeTable;

@end

@implementation Code128Generator

#pragma mark -- 私有code128编码方法
- (NSString *)__encodeCharacter:(NSString *)character {
    return CODE128_CHARACTER_ENCODINGS[
                                       [CODE128_ALPHABET_STRING rangeOfString:character].location];
}

- (NSUInteger)__startCodeTableValue:
(Code128GeneratorCodeTable)startCodeTable {
    NSUInteger codeTableValue = 0;
    switch (self.autoCodeTable.startCodeTable) {
        case Code128GeneratorCodeTableA:
            codeTableValue = self.codeTableSize - 4;
            break;
        case Code128GeneratorCodeTableB:
            codeTableValue = self.codeTableSize - 3;
            break;
        case Code128GeneratorCodeTableC:
            codeTableValue = self.codeTableSize - 2;
            break;
        default:
            break;
    }
    return codeTableValue;
}

- (NSUInteger)__middleCodeTableValue:(Code128GeneratorCodeTable)codeTable {
    NSUInteger codeTableValue = 0;
    switch (codeTable) {
        case Code128GeneratorCodeTableA:
            codeTableValue = self.codeTableSize - 6;
            break;
        case Code128GeneratorCodeTableB:
            codeTableValue = self.codeTableSize - 7;
            break;
        case Code128GeneratorCodeTableC:
            codeTableValue = self.codeTableSize - 8;
            break;
        default:
            break;
    }
    return codeTableValue;
}

- (void)__calculateContinousDigitsWithContents:(NSString *)contents
                              defaultCodeTable:
(Code128GeneratorCodeTable)defaultCodeTable
                          continousDigitsRange:(NSRange)range {
    NSUInteger currentIndex = range.location + range.length;
    BOOL isFinished = NO;
    if (currentIndex == contents.length) {
        isFinished = YES;
    }
    
    if ((range.location == 0 && range.length >= 4) ||
        ((range.location > 0 && range.length >= 6))) {
        BOOL isOrphanDigitUsed = NO;
        
        // Use START C when continous digits are found from range.location == 0
        if (range.location == 0) {
            self.autoCodeTable.startCodeTable = Code128GeneratorCodeTableC;
        } else {
            if (range.length % 2 == 1) {
                NSUInteger digitValue =
                [CODE128_ALPHABET_STRING
                 rangeOfString:[contents
                                substringWithRange:NSMakeRange(range.location,
                                                               1)]].location;
                [self.autoCodeTable.sequence
                 addObject:[NSNumber numberWithInteger:digitValue]];
                isOrphanDigitUsed = YES;
            }
            [self.autoCodeTable.sequence
             addObject:[NSNumber numberWithInteger:
                        [self __middleCodeTableValue:
                         Code128GeneratorCodeTableC]]];
        }
        
        // Insert all xx combinations
        for (int i = 0; i < range.length / 2; i++) {
            NSUInteger startIndex = range.location + i * 2;
            int digitValue = [[contents
                               substringWithRange:NSMakeRange(isOrphanDigitUsed ? startIndex + 1
                                                              : startIndex,
                                                              2)] intValue];
            [self.autoCodeTable.sequence
             addObject:[NSNumber numberWithInt:digitValue]];
        }
        
        if ((range.length % 2 == 1 && !isOrphanDigitUsed) || !isFinished) {
            [self.autoCodeTable.sequence
             addObject:[NSNumber numberWithInteger:[self __middleCodeTableValue:
                                                    defaultCodeTable]]];
        }
        
        if (range.length % 2 == 1 && !isOrphanDigitUsed) {
            NSUInteger digitValue =
            [CODE128_ALPHABET_STRING
             rangeOfString:[contents
                            substringWithRange:NSMakeRange(currentIndex - 1,
                                                           1)]].location;
            [self.autoCodeTable.sequence
             addObject:[NSNumber numberWithInteger:digitValue]];
        }
        
        if (!isFinished) {
            NSString *character =
            [contents substringWithRange:NSMakeRange(currentIndex, 1)];
            NSUInteger characterValue =
            [CODE128_ALPHABET_STRING rangeOfString:character].location;
            [self.autoCodeTable.sequence
             addObject:[NSNumber numberWithInteger:characterValue]];
        }
    } else {
        for (NSUInteger j = range.location;
             j <= (isFinished ? currentIndex - 1 : currentIndex); j++) {
            NSUInteger characterValue =
            [CODE128_ALPHABET_STRING
             rangeOfString:[contents substringWithRange:NSMakeRange(j, 1)]]
            .location;
            [self.autoCodeTable.sequence
             addObject:[NSNumber numberWithInteger:characterValue]];
        }
    }
}

- (void)__calculateAutoCodeTableWithContents:(NSString *)contents {
    if (self.codeTable == Code128GeneratorCodeTableAuto) {
        // Init auto code table when the other code table has not been selected
        self.autoCodeTable = [[AutoCodeTable alloc] init];
        
        // Select the short code table A as default code table
        Code128GeneratorCodeTable defaultCodeTable = Code128GeneratorCodeTableA;
        
        // Determine whether to use code table B
        NSString *CODE128_ALPHABET_STRING_A =
        [CODE128_ALPHABET_STRING substringToIndex:64];
        for (int i = 0; i < contents.length; i++) {
            if ([CODE128_ALPHABET_STRING_A
                 rangeOfString:[contents substringWithRange:NSMakeRange(i, 1)]]
                .location == NSNotFound &&
                defaultCodeTable == Code128GeneratorCodeTableA) {
                defaultCodeTable = Code128GeneratorCodeTableB;
                break;
            }
        }
        
        NSUInteger continousDigitsStartIndex = NSNotFound;
        for (int i = 0; i < contents.length; i++) {
            NSString *character = [contents substringWithRange:NSMakeRange(i, 1)];
            NSRange continousDigitsRange = NSMakeRange(0, 0);
            if ([DIGITS_STRING rangeOfString:character].location == NSNotFound) {
                // Non digit found
                if (continousDigitsStartIndex != NSNotFound) {
                    continousDigitsRange = NSMakeRange(continousDigitsStartIndex,
                                                       i - continousDigitsStartIndex);
                } else {
                    NSUInteger characterValue =
                    [CODE128_ALPHABET_STRING rangeOfString:character].location;
                    [self.autoCodeTable.sequence
                     addObject:[NSNumber numberWithInteger:characterValue]];
                }
            } else {
                // Digit found
                if (continousDigitsStartIndex == NSNotFound) {
                    continousDigitsStartIndex = i;
                } else if (i == (contents.length - 1)) {
                    continousDigitsRange = NSMakeRange(continousDigitsStartIndex,
                                                       i - continousDigitsStartIndex + 1);
                }
            }
            
            if (continousDigitsRange.length != 0) {
                [self __calculateContinousDigitsWithContents:contents
                                            defaultCodeTable:defaultCodeTable
                                        continousDigitsRange:continousDigitsRange];
                continousDigitsStartIndex = NSNotFound;
            } else if (continousDigitsStartIndex == contents.length - 1 && continousDigitsRange.length == 0) {
                NSUInteger characterValue =
                [CODE128_ALPHABET_STRING rangeOfString:character].location;
                [self.autoCodeTable.sequence
                 addObject:[NSNumber numberWithInteger:characterValue]];
            }
        }
        
        if (self.autoCodeTable.startCodeTable == Code128GeneratorCodeTableAuto) {
            self.autoCodeTable.startCodeTable = defaultCodeTable;
        }
    }
}

#pragma mark -- 初始化
- (id)initWithContents:(NSString *)contents {
    self = [super init];
    if (self) {
        /*Code 128 有A、B、C格式，主要看条形码所对应字符串的类型。一般说来：
         数字、大写字母和控制字符组成的字符串用A格式，如ABC、AB123；
         数字、大小字母和特殊字符组成的字符串用B格式，如Abc123、a-123（B）；
         双位数字组成的字符串用C格式，如1234、00008182。
         实际上，Code 128 编码有码元最短的原则性要求。譬如纯数字12345678，如果采用C格式，仅有4码元（2位数字为1码元）；如果采用A、B格式，有8码元（1位数字为1码元）。简单条形码，往往可以使用单一的A、B或C格式；复杂条形码，为了做到码元最短，则可能包含两种乃至三种格式。*/
        self.codeTable = Code128GeneratorCodeTableAuto;
        self.codeTableSize =
        (NSUInteger)(sizeof(CODE128_CHARACTER_ENCODINGS) / sizeof(NSString *));
    }
    return self;
}

#pragma mark -- 检测传入内容是否有效
- (BOOL)isContentsValid:(NSString *)contents {
    if (contents.length > 0) {
        for (int i = 0; i < contents.length; i++) {
            if ([CODE128_ALPHABET_STRING
                 rangeOfString:[contents substringWithRange:NSMakeRange(i, 1)]]
                .location == NSNotFound) {
                return NO;
            }
        }
        switch (self.codeTable) {
            case Code128GeneratorCodeTableAuto:
                [self __calculateAutoCodeTableWithContents:contents];
                return YES;
            case Code128GeneratorCodeTableA: {
                NSString *CODE128_ALPHABET_STRING_A =
                [CODE128_ALPHABET_STRING substringToIndex:64];
                for (int i = 0; i < contents.length; i++) {
                    if ([CODE128_ALPHABET_STRING_A
                         rangeOfString:[contents substringWithRange:NSMakeRange(i, 1)]]
                        .location == NSNotFound) {
                        return NO;
                    }
                }
                return YES;
            }
            case Code128GeneratorCodeTableB:
                //                for (int i = 0; i < contents.length; i++) {
                //                    if ([CODE128_ALPHABET_STRING
                //                         rangeOfString:[contents substringWithRange:NSMakeRange(i, 1)]]
                //                        .location == NSNotFound) {
                //                        return NO;
                //                    }
                //                }
                return YES;
            case Code128GeneratorCodeTableC:
                if (contents.length % 2 == 0 &&
                    [contents rangeOfCharacterFromSet:
                     [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                    .location == NSNotFound) {
                    return YES;
                }
                return NO;
            default:
                return NO;
        }
    }
    return NO;
}

#pragma mark -- 起始码
- (NSString *)initiator {
    NSString *initiator = nil;
    switch (self.codeTable) {
        case Code128GeneratorCodeTableAuto:
            initiator = CODE128_CHARACTER_ENCODINGS[
                                                    [self __startCodeTableValue:self.autoCodeTable.startCodeTable]];
            break;
        case Code128GeneratorCodeTableA:
        case Code128GeneratorCodeTableB:
        case Code128GeneratorCodeTableC:
        default:
            initiator = CODE128_CHARACTER_ENCODINGS[
                                                    [self __startCodeTableValue:self.codeTable]];
            break;
    }
    return initiator;
}

#pragma mark -- 终止码
- (NSString *)terminator {
    //终止码固定
    return [NSString
            stringWithFormat:@"%@%@",
            CODE128_CHARACTER_ENCODINGS[self.codeTableSize - 1],
            @"11"];
}

#pragma mark -- 对传入内容进行编码
- (NSString *)barcode:(NSString *)contents {
    NSMutableString *barcode = [[NSMutableString alloc] initWithString:@""];
    
    switch (self.codeTable) {
        case Code128GeneratorCodeTableAuto:
            for (int i = 0; i < self.autoCodeTable.sequence.count; i++) {
                [barcode appendString:CODE128_CHARACTER_ENCODINGS[
                                                                  [self.autoCodeTable.sequence[i] intValue]]];
            }
            break;
        case Code128GeneratorCodeTableA:
        case Code128GeneratorCodeTableB:
            for (int i = 0; i < contents.length; i++) {
                [barcode appendString:[self __encodeCharacter:
                                       [contents substringWithRange:NSMakeRange(
                                                                                i, 1)]]];
            }
            break;
        case Code128GeneratorCodeTableC:
            for (int i = 0; i < contents.length; i++) {
                if (i % 2 == 1) {
                    continue;
                } else {
                    int value = [[contents substringWithRange:NSMakeRange(i, 2)] intValue];
                    [barcode appendString:CODE128_CHARACTER_ENCODINGS[value]];
                }
            }
            break;
    }
    if ([self respondsToSelector:@selector(validate:)]) {
        [barcode appendString:[self validate:contents]];
    }
    return [NSString stringWithString:barcode];
}

#pragma mark - ValidateDelegate
- (NSString *)validate:(NSString *)contents {
    int sum = 0;
    switch (self.codeTable) {
        case Code128GeneratorCodeTableAuto:
            sum += [self __startCodeTableValue:self.autoCodeTable.startCodeTable];
            for (int i = 0; i < self.autoCodeTable.sequence.count; i++) {
                sum += [self.autoCodeTable.sequence[i] intValue] * (i + 1);
            }
            break;
        case Code128GeneratorCodeTableA:
            sum = -1; // START A = self.codeTableSize - 4 = START B - 1
        case Code128GeneratorCodeTableB:
            sum += self.codeTableSize - 3; // START B
            for (int i = 0; i < contents.length; i++) {
                NSUInteger characterValue =
                [CODE128_ALPHABET_STRING
                 rangeOfString:[contents substringWithRange:NSMakeRange(i, 1)]]
                .location;
                sum += characterValue * (i + 1);
            }
            break;
        case Code128GeneratorCodeTableC:
            sum += self.codeTableSize - 2; // START C
            for (int i = 0; i < contents.length; i++) {
                if (i % 2 == 1) {
                    continue;
                } else {
                    int value = [[contents substringWithRange:NSMakeRange(i, 2)] intValue];
                    sum += value * (i / 2 + 1);
                }
            }
            break;
        default:
            break;
    }
    return CODE128_CHARACTER_ENCODINGS[sum % 103];
}


- (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height codeType:(NSInteger)codeType{
    if(code == nil || code.length <= 0)
        return nil;
    if (codeType == 1) {
        
        codeType = 1;
        Code128Generator *codeGen = [[Code128Generator alloc]initWithContents:code];
        UIImage *image = [codeGen genCodeWithContents:code machineReadableCodeObjectType:@"org.iso.Code128"];
        //对图片进行拉伸或压缩处理
        CGFloat scaleX = width / image.size.width; // extent 返回图片的frame
        CGFloat scaleY = height / image.size.height;
        
        //指定宽高值无效时使用原图片的大小，不进行拉伸
        if(scaleX <= 0){
            scaleX = 1.0;
        }
        if(scaleY <= 0){
            scaleY = 1.0;
        }
        CGFloat scaleSize = scaleX;
        if (scaleSize > scaleY) {
            scaleSize = scaleY;
        }
        CGFloat destWidth = image.size.width * scaleSize;
        CGFloat destHeight = image.size.height * scaleSize;
        //    NSLog(@"========size:%@",NSStringFromCGSize(image.size));
        
        UIGraphicsBeginImageContext(CGSizeMake(destWidth, destHeight));
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
        [image drawInRect:CGRectMake(0, 0, destWidth, destHeight)];
        UIImage *target = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //    NSLog(@"========target:%@",NSStringFromCGSize(target.size));
        return target;
    }else{
        return nil;
    }
}

- (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height codeType:(NSInteger)codeType{
    if(code == nil || code.length <= 0)
        return nil;
    if (codeType == 2) {
        codeType = 2;
        CIImage *qrcodeImage;
        CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        [filter setDefaults];
        NSData *data = [code dataUsingEncoding:NSUTF8StringEncoding];
        [filter setValue:data forKey:@"inputMessage"];
        [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
        
        qrcodeImage = [filter outputImage];
        CIContext *context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer:@(YES)}];
        CGImageRef cgImage =
        [context createCGImage:qrcodeImage fromRect:[qrcodeImage extent]];
        UIImage *image = [UIImage imageWithCGImage:cgImage
                                             scale:1
                                       orientation:UIImageOrientationUp];
        CGImageRelease(cgImage);
        //    NSLog(@"========1size:%@",NSStringFromCGSize(qrcodeImage.extent.size));
        
        //对图片进行拉伸或压缩处理
        CGFloat scaleX = width / qrcodeImage.extent.size.width; // extent 返回图片的frame
        CGFloat scaleY = height / qrcodeImage.extent.size.height;
        //指定宽高值无效时使用原图片的大小，不进行拉伸
        if(scaleX <= 0){
            scaleX = 1.0;
        }
        if(scaleY <= 0){
            scaleY = 1.0;
        }
        CGFloat scaleSize = scaleX;
        if(scaleSize > scaleY){
            scaleSize = scaleY;
        }
        //     NSLog(@"========size:%f,%f",scaleX,scaleY);
        CGFloat destWidth = qrcodeImage.extent.size.width * scaleSize;
        CGFloat destHeight = qrcodeImage.extent.size.height * scaleSize;
        
        UIGraphicsBeginImageContext(CGSizeMake(destWidth, destHeight));
        CGContextRef contextRef = UIGraphicsGetCurrentContext();
        CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
        [image drawInRect:CGRectMake(0, 0, destWidth, destHeight)];
        UIImage *target = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //NSLog(@"========size:%@",NSStringFromCGSize(target.size));
        return target;
    }
    else{
        return nil;
    }
}

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
- (NSString *)saveSandBoxImageAtPath:(UIImage *)image imgName:(NSString *)imgName
{
    NSFileManager *fm = [NSFileManager defaultManager];
    //若文件夹不存在，创建文件夹
    NSError *error;
    if (![fm fileExistsAtPath:[self imageDirectory]]) {
        [fm createDirectoryAtPath:[self imageDirectory] withIntermediateDirectories:YES attributes:nil error: &error];
        if (error) {
            return nil;
        }
    }
    
    NSString *photoName = nil;
    if(imgName == nil || imgName.length <= 0){//没有指定图片名称时，以时间命名
        UInt64 recordTime = [[NSDate date] timeIntervalSince1970] * 1000;
        photoName = [NSString stringWithFormat:@"IMG%llu.jpg", recordTime];
    }else{
        photoName = [NSString stringWithFormat:@"%@.jpg", imgName];
    }
    
    NSString *localPath = [[self imageDirectory]stringByAppendingPathComponent:photoName];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    if(data)
        [data writeToFile:localPath atomically:YES];
    
    //    NSLog(@"=======%@",[fm fileExistsAtPath:localPath]?@"exist":@"no");
    return localPath;
}

- (NSString *)imageDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *imageDirectory = [documentDirectory stringByAppendingPathComponent:
                                @"Image"];
    return imageDirectory;
}

@end
