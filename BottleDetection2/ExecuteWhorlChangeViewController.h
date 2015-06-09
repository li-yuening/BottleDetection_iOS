//
//  ExecuteWhorlChangeViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/7.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXPullDownMenu.h"

@interface ExecuteWhorlChangeViewController : UITableViewController<MXPullDownMenuDelegate>
@property (weak, nonatomic) IBOutlet UILabel *bottleDetectNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;

@property (nonatomic,strong) NSDictionary *sendParameters;
@property (weak, nonatomic) IBOutlet UITextField *valveNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *testPressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *testMediumLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBVCButton;
- (IBAction)saveBVCResult:(id)sender;
@property (nonatomic,strong) NSMutableData *datas;
@property (nonatomic,strong) NSString *bottleValveType;
@property (nonatomic,strong) NSString *bottleValveChangeResult;
- (IBAction)keyboardHide:(id)sender;

@end
