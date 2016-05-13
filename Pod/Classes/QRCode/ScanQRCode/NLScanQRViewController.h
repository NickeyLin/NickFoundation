//
//  NLScanQRViewController.h
//  NLScanQRViewController
//
//  Created by Nick.Lin on 15/11/27.
//  Copyright © 2015年 ChangHong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "NLScanQRUtil.h"

@interface NLScanQRViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic, assign, readonly) BOOL lighting;//是否开启闪光灯
@property(nonatomic, strong)    AVCaptureSession *session;
@property(nonatomic, strong)    AVCaptureVideoPreviewLayer *previewLayer;
@property(nonatomic, strong)    UIView *scanRectView;//扫描区域

/**
 *  @author Bijiao Wang, 15-10-15 15:25:36
 *
 *  控制闪光灯的开关
 *
 *  @param open
 *      开启闪光灯：YES，关闭闪光灯：NO
 */
- (void)turnLight:(BOOL)open;

/**
 *  @author Bijiao Wang, 15-10-16 09:14:08
 *
 *  注册扫码回调函数
 *
 *  @param finishingBlock
 *      回调函数，扫码结束后将扫描结果返回
 */
- (void)setCompleteBlock:(ScanQRCompleteBlock)finishingBlock;
@end
