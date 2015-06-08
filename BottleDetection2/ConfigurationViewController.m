//
//  ConfigurationViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/23.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "ConfigurationViewController.h"
#import "AppDelegate.h"

@implementation ConfigurationViewController

- (void)viewWillAppear:(BOOL)animated {
    self.tableView.scrollEnabled = NO;
    self.navigationController.toolbarHidden = YES;
}

- (IBAction)saveIPAddress:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSString *ipHead = @"http://";
    if ([self.ipAddressLabel.text isEqualToString:@""]) {
        appDelegate.ipAddress = [ipHead stringByAppendingString:@"192.168.1.109"];
    } else {
        appDelegate.ipAddress = [ipHead stringByAppendingString:self.ipAddressLabel.text];
    }
    NSString *ipTail = @":8080/BottleDetection2/servlet/";
    appDelegate.ipAddress = [appDelegate.ipAddress stringByAppendingString:ipTail];
    NSLog(@"%@",appDelegate.ipAddress);
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
