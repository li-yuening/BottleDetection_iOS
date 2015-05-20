//
//  AllBottleSearchViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/2.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllBottleSearchViewController : UITableViewController
@property (nonatomic,strong) NSMutableArray* listData;
//-(void)reloadView:(NSDictionary *)res;
-(void)startRequest;
@end
