//
//  NLQRCodeViewController.m
//  NickFoundation
//
//  Created by Nick.Lin on 16/6/28.
//  Copyright © 2016年 Nick.Lin. All rights reserved.
//

#import "NLQRCodeViewController.h"
#import <NickFoundation/NLScanQRUtil.h>

@interface NLQRCodeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;

@end

@implementation NLQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionQRCode:(UIButton *)sender {
    [NLScanQRUtil presentQRScanInViewController:self Complete:^(NSString *result, NSError *error) {
        if (error) {
            self.lblMessage.text = error.localizedDescription;
        }else{
            self.lblMessage.text = result;
        }
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
