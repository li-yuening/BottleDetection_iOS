//
//  ExecuteAirProofViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/7.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXPullDownMenu.h"

@interface ExecuteAirProofViewController : UITableViewController<MXPullDownMenuDelegate>
@property (nonatomic,strong) NSDictionary *sendParameters;
@property (nonatomic,strong) NSMutableData *datas;
@property (nonatomic,strong) NSString *airProofTestMethod;
@property (weak, nonatomic) IBOutlet UILabel *testMediumLabel;
@property (weak, nonatomic) IBOutlet UILabel *testMediumTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *testPressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *testKeepTimeLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *testResultSegment;
@property (weak, nonatomic) IBOutlet UILabel *bottleDetectNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;
- (IBAction)saveAPResult:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveAPButton;

@end
