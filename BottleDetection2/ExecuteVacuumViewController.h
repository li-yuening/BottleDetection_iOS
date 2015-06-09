//
//  ExecuteVacuumViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/7.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXPullDownMenu.h"

@interface ExecuteVacuumViewController : UITableViewController<MXPullDownMenuDelegate>
@property (weak, nonatomic) IBOutlet UILabel *bottleDetectNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;

@property (weak, nonatomic) IBOutlet UITextField *vacuumPressureTextField;
@property (weak, nonatomic) IBOutlet UILabel *nextCheckDateLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *vacuumOverCell;
- (IBAction)saveVacuumResult:(id)sender;
- (IBAction)keyboardHide:(id)sender;
- (NSString *)makeDate:(int)validTime;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveVacuumButton;
@property (nonatomic,strong) NSDictionary *sendParameters;
@property (nonatomic,strong) NSMutableData *datas;
@property (readwrite,assign) int validTime;

@end
