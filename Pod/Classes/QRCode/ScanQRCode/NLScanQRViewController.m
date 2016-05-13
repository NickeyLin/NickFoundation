//
//  NLScanQRViewController.h
//  NLScanQRViewController
//
//  Created by Nick.Lin on 15/11/27.
//  Copyright © 2015年 ChangHong. All rights reserved.
//

#import "NLScanQRViewController.h"
#import "NLAnimation.h"

@interface NLScanQRViewController (){
    __weak ScanQRCompleteBlock _completeBlock;
    UIView *_scanLayer;
}
@property(nonatomic) CGFloat    scanMaskX;
@property(nonatomic) CGFloat    scanMaskY;
@property(nonatomic) CGRect     scanMaskRect;//扫描位置
@property(nonatomic, strong)    UIButton    *btnFlash;//闪光灯
@end

@implementation NLScanQRViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lighting = NO;//默认关闭闪光灯
    //扫描区域
    _scanMaskRect = CGRectMake(0, 0,CGRectGetWidth([UIScreen mainScreen].bounds)/3*2, CGRectGetWidth([UIScreen mainScreen].bounds)/3*2);//CGRectMake(_scanMaskX, _scanMaskY, SCAN_WIDTH, SCAN_HEIGHT);
    
    //边框
    _scanRectView = [[UIView alloc]initWithFrame:_scanMaskRect];
    _scanRectView.backgroundColor = [UIColor clearColor];
    [_scanRectView.layer setBorderWidth:4];
    _scanRectView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    //阴影
    _scanRectView.layer.shadowOffset = CGSizeMake(2, 2);
    _scanRectView.layer.shadowRadius = 5;
    _scanRectView.layer.shadowOpacity = 1;
    _scanRectView.layer.shadowColor = [UIColor blackColor].CGColor;
    _scanRectView.frame = CGRectMake(0, 0,CGRectGetWidth([UIScreen mainScreen].bounds)/3*2, CGRectGetWidth([UIScreen mainScreen].bounds)/3*2);
    
    _scanRectView.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds)/2, CGRectGetHeight([UIScreen mainScreen].bounds)/2 - 50);
    
    
    //扫描线
    _scanLayer = [[UIView alloc] init];
    _scanLayer.frame = CGRectMake(0, 0, _scanRectView.bounds.size.width, 1);
    _scanLayer.backgroundColor = [UIColor greenColor];
    [_scanRectView addSubview:_scanLayer];
    [self.view addSubview:_scanRectView];
    
    //提示
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, _scanRectView.frame.origin.y+_scanRectView.frame.size.height+20, self.view.frame.size.width, 30)];
    label.text = @"将二维码/条形码放到框内";
    label.textAlignment = NSTextAlignmentCenter;
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont systemFontOfSize:16]];
    [self.view addSubview:label];
    
    //闪光灯
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    NSBundle *imageBundle = [NSBundle bundleForClass:[self class]];
    imageBundle = [NSBundle bundleWithPath:[[imageBundle bundlePath]stringByAppendingPathComponent:@"NickFoundation.bundle"]];
    
    _btnFlash = [[UIButton alloc] initWithFrame:CGRectMake(_scanRectView.center.x - 20, statusBarHeight+navBarHeight +(label.frame.origin.y + label.frame.size.height), 40, 40)];
    [_btnFlash setBackgroundImage:[UIImage imageNamed:@"camera_flash_off" inBundle:imageBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
    [_btnFlash setBackgroundImage:[UIImage imageNamed:@"camera_flash_on" inBundle:imageBundle compatibleWithTraitCollection:nil] forState:UIControlStateSelected];

    [_btnFlash addTarget:self action:@selector(actionFlash:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnFlash];
    
    [self moveScanLayer];
    
    [self start];
    
}

/**
 *  请求摄像头，设置相关参数，开始捕获条形码或二维码
 */
- (void)start
{
    // 1. 摄像头设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 2. 设置输入
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        NSLog(@"没有摄像头-%@", error.localizedDescription);
        if(_completeBlock){
            _completeBlock(nil, error);
        }
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    // 3. 设置输出(Metadata元数据)
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    // 3.1 设置输出的代理
    // 说明：使用主线程队列，相应比较同步，使用其他队列，相应不同步，容易让用户产生不好的体验
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 4. 拍摄会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    // 添加session的输入和输出
    [session addInput:input];
    [session addOutput:output];
    //使用1080p的图像输出
    session.sessionPreset = AVCaptureSessionPreset1920x1080;
    
    // 4.1 设置输出的格式
    // 提示：一定要先设置会话的输出为output之后，再指定输出的元数据类型！
    [output setMetadataObjectTypes:[output availableMetadataObjectTypes]];
    
    // 5. 设置预览图层（用来让用户能够看到扫描情况）
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:session];
    // 5.1 设置preview图层的属性
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    // 5.2 设置preview图层的大小
    preview.frame = [UIScreen mainScreen].bounds;
    
    self.previewLayer = preview;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGRect cropRect = self.scanRectView.frame;
    CGFloat p1 = size.height/size.width;
    CGFloat p2 = 1920./1080.;  //使用1080p的图像输出
    if (p1 < p2) {
        CGFloat fixHeight = [UIScreen mainScreen].bounds.size.width * 1920. / 1080.;
        CGFloat fixPadding = (fixHeight - size.height)/2;
        output.rectOfInterest = CGRectMake((cropRect.origin.y + fixPadding)/fixHeight,
                                           cropRect.origin.x/size.width,
                                           cropRect.size.height/fixHeight,
                                           cropRect.size.width/size.width);
    } else {
        CGFloat fixWidth = [UIScreen mainScreen].bounds.size.height * 1080. / 1920.;
        CGFloat fixPadding = (fixWidth - size.width)/2;
        output.rectOfInterest = CGRectMake(cropRect.origin.y/size.height,
                                           (cropRect.origin.x + fixPadding)/fixWidth,
                                           cropRect.size.height/size.height,
                                           cropRect.size.width/fixWidth);
    }
    self.session = session;
}

/**
 *  以动画形式绘制扫描线
 */
- (void)moveScanLayer{
    CABasicAnimation *animation = [NLAnimation moveToY:self.scanRectView.frame.size.height withDuration:2];
    animation.autoreverses = YES;
    animation.repeatCount = INT_MAX;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
    [_scanLayer.layer addAnimation:animation forKey:@"scan"];
}
- (void)stopScanLayer{
    [_scanLayer.layer removeAllAnimations];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(applicationWillEnterForeground:)   name:UIApplicationWillEnterForegroundNotification  object:nil];
    //
    //    [[NSNotificationCenter defaultCenter]  addObserver:self    selector:@selector(applicationDidEnterBackground:)  name:UIApplicationDidEnterBackgroundNotification  object:nil];
    [self.session startRunning];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self turnLight:NO];
    [self.session stopRunning];
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

#pragma mark - delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    NSLog(@"%@", metadataObjects);
    if (metadataObjects.count > 0) {
        
        AVMetadataMachineReadableCodeObject *obj = [metadataObjects firstObject];
        if(_completeBlock &&[obj isKindOfClass:[AVMetadataMachineReadableCodeObject class]]){
            [self turnLight:NO];
            [self.session stopRunning];
            _completeBlock(obj.stringValue, nil);
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    [self stopScanLayer];
}

#pragma mark -- 点击按钮相应事件
- (void) actionFlash:(UIButton *)sender{
    
    BOOL open = !_lighting;
    sender.selected = open;

    [self turnLight:open];
}

#pragma mark -- 控制闪光灯
- (void)turnLight:(BOOL)open
{
    _lighting = open;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (open) {
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        [device unlockForConfiguration];
    }
}

- (void)setCompleteBlock:(ScanQRCompleteBlock)finishingBlock{
    _completeBlock = finishingBlock;
}

//- (void)applicationWillEnterForeground:(NSNotification*)note {
//    [self.session  startRunning];
//}
//
//- (void)applicationDidEnterBackground:(NSNotification*)note {
//    [self turnLight:NO];
//    [self.session stopRunning];
//
//}

//-(BOOL) navigationShouldPopOnBackButton ///在这个方法里写返回按钮的事件处理
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];

//    [self turnLight:NO];
//    [self.session stopRunning];
//    [self.navigationController popViewControllerAnimated:YES];
//    return YES;
//}

@end