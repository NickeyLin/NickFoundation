//
//  NSData+DES.m
//  SH
//
//  Created by Nick.Lin on 16/5/27.
//  Copyright © 2016年 Nick. All rights reserved.
//

#import "NSData+DES.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (DES)
- (NSData *)tripleDESEncodeWithKey:(NSData *)key error:(NSError **)error{
    CCCryptorStatus ccStatus;
    //    Byte *key = (Byte *)[NSString key];
    const void *dataIn = [self bytes];
    size_t dataInLength = [self length];
    size_t dataOutAvailable = (dataInLength + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    void *dataOut = malloc( dataOutAvailable * sizeof(size_t));
    
    size_t dataOutMoved;
    
    ccStatus = CCCrypt(kCCEncrypt, kCCAlgorithm3DES, kCCOptionPKCS7Padding | kCCOptionECBMode, [key bytes], kCCKeySize3DES, nil, dataIn, dataInLength, dataOut, dataOutAvailable, &dataOutMoved);
    
    if (ccStatus == kCCSuccess) {
        *error = nil;
        return [NSData dataWithBytes:dataOut length:dataOutAvailable];
    }
    
    NSString *errorMessage = @"UNKNOWN ERROR";
    if (ccStatus == kCCParamError){
        errorMessage = @"PARAM ERROR";
    }else if (ccStatus == kCCBufferTooSmall){
        errorMessage = @"BUFFER TOO SMALL";
    }else if (ccStatus == kCCMemoryFailure) {
        errorMessage = @"MEMORY FAILURE";
        
    }else if (ccStatus == kCCAlignmentError) {
        errorMessage = @"ALIGNMENT";
    }else if (ccStatus == kCCDecodeError) {
        errorMessage = @"DECODE ERROR";
    }else if (ccStatus == kCCUnimplemented) {
        errorMessage = @"UNIMPLEMENTED";
    }
    *error = [NSError errorWithDomain:@"3DES Encode" code:ccStatus userInfo:@{NSLocalizedDescriptionKey : errorMessage}];
    return nil;
}

- (NSData *)tripleDESDecodeWithKey:(NSData *)key error:(NSError **)error{
    
    NSData *encryptData = self;
    
    CCCryptorStatus ccStatus;
    //    SignedByte *key = (SignedByte *)[NSString key];
    const void *dataIn = [encryptData bytes];
    size_t dataInLength = [encryptData length];
    size_t dataOutAvailable = (dataInLength + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    void *dataOut = malloc( dataOutAvailable * sizeof(size_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);
    
    size_t dataOutMoved;
    
    ccStatus = CCCrypt(kCCDecrypt, kCCAlgorithm3DES, kCCOptionPKCS7Padding | kCCOptionECBMode, (SignedByte *)[key bytes], kCCKeySize3DES, nil, dataIn, dataInLength, dataOut, dataOutAvailable, &dataOutMoved);
    
    if (ccStatus == kCCSuccess) {
        *error = nil;
        return [NSData dataWithBytes:dataOut length:dataOutMoved];
    }
    
    NSString *errorMessage = @"UNKNOWN ERROR";
    if (ccStatus == kCCParamError){
        errorMessage = @"PARAM ERROR";
    }else if (ccStatus == kCCBufferTooSmall){
        errorMessage = @"BUFFER TOO SMALL";
    }else if (ccStatus == kCCMemoryFailure) {
        errorMessage = @"MEMORY FAILURE";
        
    }else if (ccStatus == kCCAlignmentError) {
        errorMessage = @"ALIGNMENT";
    }else if (ccStatus == kCCDecodeError) {
        errorMessage = @"DECODE ERROR";
    }else if (ccStatus == kCCUnimplemented) {
        errorMessage = @"UNIMPLEMENTED";
    }
        *error = [NSError errorWithDomain:@"3DES decode" code:ccStatus userInfo:@{NSLocalizedDescriptionKey : errorMessage}];
    //    NSString *result = [[[NSString alloc] initWithData:[NSData dataWithBytes:dataOut length:dataOutMoved] encoding:NSUTF8StringEncoding] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    result = [result stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return nil;
}

@end
