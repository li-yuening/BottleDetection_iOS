//
//  MainViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/2.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITableViewController

- (IBAction)logOut:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *mainNavigation;
@property (weak, nonatomic) IBOutlet UITableViewCell *BottleReceiveCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *WaterTestPressureCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *GlobalDetectionCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *InnerDryCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *AirProofTestCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *NoneFunctionCell;
- (void)checkRights;
@end
