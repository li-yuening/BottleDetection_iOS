//
//  AllBottleSearchViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/2.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllBottleSearchViewController : UITableViewController <NSURLConnectionDelegate>
@property (nonatomic,strong) NSMutableArray* listData;
@property (nonatomic,strong) NSMutableData *datas;
//-(void)reloadView:(NSDictionary *)res;
-(void)startRequest;
@end
