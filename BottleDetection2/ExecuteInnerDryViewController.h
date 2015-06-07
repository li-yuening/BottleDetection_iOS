//
//  ExecuteInnerDryViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/6.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExecuteInnerDryViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *bottleDetectNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *innerDryCell;
@property (nonatomic,strong) NSMutableData *datas;
@property (nonatomic,strong) NSDictionary *sendParameters;
- (IBAction)saveInnerDry:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveIDButton;

@end
