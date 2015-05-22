//
//  ConfigurationViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/23.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigurationViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *ipAddressLabel;
- (IBAction)saveIPAddress:(id)sender;

@end
