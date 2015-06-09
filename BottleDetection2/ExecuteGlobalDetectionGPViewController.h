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
@property (weak, nonatomic) IBOutlet UITextField *soundDetectTextField;
@property (weak, nonatomic) IBOutlet UITableViewCell *metalDetectCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *heatDetectCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *roundDetectCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *innerDetectCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *whorlDetectCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *soundDetectCell;
- (IBAction)saveGDGPResult:(id)sender;
@property (nonatomic,strong) NSMutableData *datas;
@property (nonatomic,strong) NSDictionary *sendParameters;
@property (nonatomic,strong) NSString *appearDetail;
@property (nonatomic,strong) NSString *soundDetail;
@property (nonatomic,strong) NSString *whorlDetail;
@property (nonatomic,strong) NSString *innerDetail;
@property (nonatomic,strong) NSString *globalSub5Detail;
@property (nonatomic,strong) NSString *globalSub6Detail;
- (IBAction)keyboardHide:(id)sender;
@end
