//
//  AllBottleSearchViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/2.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllBottleSearchViewController : UITableViewController <NSURLConnectionDelegate>
@property (nonatomic,strong) NSMutableArray *listData;
@property (nonatomic,strong) NSMutableDictionary *listDataDict;
@property (nonatomic,strong) NSMutableData *datas;
@property (readwrite,assign) NSUInteger pagePresent;
@property (readwrite,assign) NSUInteger isFirstLoad;
- (IBAction)previousPage:(id)sender;
- (IBAction)nextPage:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousPageButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextPageButton;
-(void)startRequest;
@end