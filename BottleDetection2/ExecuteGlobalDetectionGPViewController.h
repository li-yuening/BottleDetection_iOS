//
//  ExecuteGlobalDetectionGPViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/24.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExecuteGlobalDetectionGPViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *bottleDetectNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *metalDetectTextField;
@property (weak, nonatomic) IBOutlet UITextField *heatDetectTextField;
@property (weak, nonatomic) IBOutlet UITextField *roundDetectTextField;
@property (weak, nonatomic) IBOutlet UITextField *innerDetectTextField;
@property (weak, nonatomic) IBOutlet UITextField *whorlDetectTextField;
@property (nonatomic,strong) NSDictionary *sendParameters;
@end
