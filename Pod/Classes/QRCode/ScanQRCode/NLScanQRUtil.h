//
//  NLScanQRUtil.h
//  Pods
//
//  Created by Nick.Lin on 16/5/12.
//
//

#import <Foundation/Foundation.h>

typedef void (^ScanQRCompleteBlock)(NSString *result, NSError *error);

@interface NLScanQRUtil : NSObject

+ (void)presentQRScanInViewController:(UIViewController *)viewController Complete:(ScanQRCompleteBlock)completeBlock;

@end
