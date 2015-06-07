//
//  InnerDryViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/6.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "InnerDryViewController.h"
#import "AppDelegate.h"
#import "NSString+URLEncoding.h"
#import "GlobalDetectCell.h"
#import "ExecuteInnerDryViewController.h"

@implementation InnerDryViewController

- (void)viewDidAppear:(BOOL)animated{
    [self startRequest];
}

- (void)startRequest {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //NSString *strURL = [[NSString alloc] initWithFormat:@"file:///Volumes/DATA/servlet/WaterTestPressure.html"];
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@",[appDelegate.ipAddress stringByAppendingString:@"InnerDry"]];
    //NSLog(@"%@",strURL);
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (connection) {
        _datas = [NSMutableData new];
    }
}

#pragma mark- NSURLConnection 回调方法
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_datas appendData:data];
}


-(void) connection:(NSURLConnection *)connection didFailWithError: (NSError *)error {
    
    NSLog(@"%@",[error localizedDescription]);
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
    NSLog(@"内部干燥界面加载完成");
    self.listData = [NSJSONSerialization JSONObjectWithData:_datas options:NSJSONReadingAllowFragments error:nil];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GlobalDetectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InnerDryCell" forIndexPath:indexPath];
    
    NSMutableDictionary*  dict = self.listData[indexPath.row];
    cell.bottleDetectNumberLabel.text = [dict objectForKey:@"bottleDetectNumber"];
    cell.bottleNumberLabel.text = [dict objectForKey:@"bottleNumber"];
    cell.carNumberLabel.text = [dict objectForKey:@"carNumber"];
    
    //cell.bottleMadeCompanyLabel.text = [dict objectForKey:@"bottleMadeCompany"];
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"executeInnerDrySegue"]) {
        ExecuteInnerDryViewController *executeInnerDryViewController = segue.destinationViewController;
        NSInteger row = [[self.tableView indexPathForSelectedRow] row];
        //NSLog(@"%ld",(long)row);
        executeInnerDryViewController.sendParameters = self.listData[row];
    }
}

@end
