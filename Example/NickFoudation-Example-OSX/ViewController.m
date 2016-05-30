//
//  ViewController.m
//  NickFoudation-Example-OSX
//
//  Created by Nick.Lin on 16/5/30.
//  Copyright © 2016年 Nick.Lin. All rights reserved.
//

#import "ViewController.h"
#import <NickFoundation/Common.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.view.layer.backgroundColor = [NSColor colorWithRGBHex:0x345678].CGColor;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
