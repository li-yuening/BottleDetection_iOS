//
//  WaterTestPressureViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/4.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterTestPressureViewController : UITableViewController
@property (nonatomic,strong) NSMutableArray* listData;
@property (nonatomic,strong) NSMutableData *datas;
- (void)startRequest;


@end
