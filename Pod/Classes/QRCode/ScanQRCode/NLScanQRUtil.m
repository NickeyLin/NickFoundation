//
//  NLScanQRUtil.m
//  Pods
//
//  Created by Nick.Lin on 16/5/12.
//
//

#if TARGET_OS_IOS

#import "NLScanQRUtil.h"
#import "NLScanQRViewController.h"

@implementation NLScanQRUtil
+ (void)presentQRScanInViewController:(UIViewController *)viewController Complete:(ScanQRCompleteBlock)completeBlock{
    if (!viewController) {
        if (completeBlock) {
            completeBlock(nil, [NSError errorWithDomain:@"QRScan" code:0x100 userInfo:@{NSLocalizedDescriptionKey:@"视图控制器不能为空！"}]);
        }
        return;
    }
    
    NLScanQRViewController *vcScanQR = [[NLScanQRViewController alloc]init];
    vcScanQR.view.backgroundColor = [UIColor blackColor];
    [vcScanQR setCompleteBlock:completeBlock];
    [viewController presentViewController:vcScanQR animated:YES completion:nil];
}

@end
#endif