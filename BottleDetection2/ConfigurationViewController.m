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

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.ipAddressLabel.placeholder = appDelegate.shortIP;
}

- (void)viewWillAppear:(BOOL)animated {
    self.tableView.scrollEnabled = NO;
    self.navigationController.toolbarHidden = YES;
}

- (IBAction)saveIPAddress:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    if (![self.ipAddressLabel.text isEqualToString:@""]) {
        appDelegate.shortIP = self.ipAddressLabel.text;
        [self writeIPPlist:appDelegate.shortIP];
        //NSLog(@"修改 %@",appDelegate.ipAddress);
    }
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)writeIPPlist:(NSString *)ip {
    //AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //获取路径对象
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    //NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"IPAddress.plist"];
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:@"IPAddress.plist"];
    NSMutableDictionary *applist = [[[NSMutableDictionary alloc]initWithContentsOfFile:path]mutableCopy];
    
    [applist setObject:ip forKey:@"ipAddress"];
    [applist writeToFile:path atomically:YES];
}
@end
