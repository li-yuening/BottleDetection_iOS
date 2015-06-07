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

@end
