//
//  ExecuteGlobalDetectionGPViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/24.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "ExecuteGlobalDetectionGPViewController.h"

@implementation ExecuteGlobalDetectionGPViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.toolbarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bottleDetectNumberLabel.text = [self.sendParameters objectForKey:@"bottleDetectNumber"];
    self.bottleNumberLabel.text = [self.sendParameters objectForKey:@"bottleNumber"];
    self.carNumberLabel.text = [self.sendParameters objectForKey:@"carNumber"];
}


@end
