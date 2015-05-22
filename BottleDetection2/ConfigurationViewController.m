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

- (IBAction)saveIPAddress:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSString *ipHead = @"http://";
    appDelegate.ipAddress = [ipHead stringByAppendingString:self.ipAddressLabel.text];
    NSString *ipTail = @":8080/BottleDetection2/servlet/";
    appDelegate.ipAddress = [appDelegate.ipAddress stringByAppendingString:ipTail];
    NSLog(@"%@",appDelegate.ipAddress);
}
@end
