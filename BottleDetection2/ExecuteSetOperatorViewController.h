//
//  ExecuteSetOperatorViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/7.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXPullDownMenu.h"

@interface ExecuteSetOperatorViewController : UITableViewController<MXPullDownMenuDelegate>
@property (nonatomic,strong) NSDictionary *sendParameters;
@property (nonatomic,strong) NSMutableData *datas;
@property (nonatomic,strong) NSString *reportExaminer;
@property (nonatomic,strong) NSString *reportChecker;
@property (weak, nonatomic) IBOutlet UILabel *bottleDetectNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextCheckDateLabel;
- (IBAction)saveSetExaminerResult:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveSEButton;

@end
