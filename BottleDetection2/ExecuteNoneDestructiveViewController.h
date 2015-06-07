//
//  ExecuteNoneDestructiveViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/7.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExecuteNoneDestructiveViewController : UITableViewController

@property (nonatomic,strong) NSMutableData *datas;
@property (nonatomic,strong) NSDictionary *sendParameters;
@property (weak, nonatomic) IBOutlet UILabel *bottleDetectNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *noneDestructiveResultSegment;
@property (weak, nonatomic) IBOutlet UITextField *noneDestructivePosition;
@property (weak, nonatomic) IBOutlet UITextField *flawNumber;
@property (weak, nonatomic) IBOutlet UITextField *flawType;
@property (weak, nonatomic) IBOutlet UITextField *flawSize;
@property (weak, nonatomic) IBOutlet UITextField *finalRating;
@property (weak, nonatomic) IBOutlet UITextField *detail;
- (IBAction)saveNDResult:(id)sender;
- (void)startNDRequest;

@end
