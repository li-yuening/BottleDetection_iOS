//
//  ExcuteChubuPanduanController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/22.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExcuteChubuPanduanController : UITableViewController
@property (weak, nonatomic) IBOutlet UITableViewCell *cpTrueCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *cpFalseCell;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveCPButton;
- (IBAction)saveCP:(id)sender;
- (void)startSaveCPRequest;
@property (weak, nonatomic) IBOutlet UILabel *bottleDetectNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *rptNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleNumberLabel;
@property (nonatomic,strong) NSMutableDictionary* listData;
@property (nonatomic,strong) NSMutableData *datas;
@property (nonatomic,strong) NSDictionary *sendParameters;
@end
