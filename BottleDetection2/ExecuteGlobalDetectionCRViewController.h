//
//  ExecuteGlobalDetectionCRViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/24.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExecuteGlobalDetectionCRViewController : UITableViewController
@property (nonatomic,strong) NSMutableData *datas;
@property (nonatomic,strong) NSDictionary *sendParameters;
@property (nonatomic,strong) NSString *appearDetail;
@property (nonatomic,strong) NSString *soundDetail;
@property (nonatomic,strong) NSString *whorlDetail;
@property (weak, nonatomic) IBOutlet UILabel *bottleDetectNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *metalDetectCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *appearDetectCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *whorlDetectCell;
@property (weak, nonatomic) IBOutlet UITextField *metalDetectTextField;
@property (weak, nonatomic) IBOutlet UITextField *whorlDetectTextField;
- (IBAction)saveGDCRResult:(id)sender;

@end
