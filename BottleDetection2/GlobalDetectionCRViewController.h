//
//  GlobalDetectionCRViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/24.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlobalDetectionCRViewController : UITableViewController
@property (nonatomic,strong) NSMutableArray* listData;
@property (nonatomic,strong) NSMutableData *datas;
- (void)startRequest;

@end
