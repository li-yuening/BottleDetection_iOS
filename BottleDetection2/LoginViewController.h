//
//  LoginViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/12.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *operatorNumber;
@property (weak, nonatomic) IBOutlet UITextField *operatorPwd;
- (IBAction)logIn:(id)sender;
- (IBAction)keyboardHide:(id)sender;
@end
