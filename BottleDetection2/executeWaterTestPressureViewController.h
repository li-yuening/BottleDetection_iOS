//
//  executeWaterTestPressureViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/5.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExecuteWaterTestPressureViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *bottleDetectNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *waterTrueCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *waterFalseCell;
- (IBAction)saveWaterResult:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveWaterButton;
@property (nonatomic,strong) NSMutableData *datas;
@property (nonatomic,strong) NSDictionary *sendParameters;
@end
