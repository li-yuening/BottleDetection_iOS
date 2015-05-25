//
//  GlobalDetectionCRViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/24.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "GlobalDetectionCRViewController.h"

@implementation GlobalDetectionCRViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.toolbarHidden = NO;
}

- (IBAction)changeToGP:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
