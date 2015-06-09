//
//  SetOperator.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/7.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "SetOperator.h"
#import "AppDelegate.h"
#import "NSString+URLEncoding.h"
#import "ExecuteSetOperatorViewController.h"
#import "SetExaminerCell.h"

@implementation SetOperator

- (void)viewDidAppear:(BOOL)animated{
    [self startRequest];
}

- (void)startRequest {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //NSString *strURL = [[NSString alloc] initWithFormat:@"file:///Volumes/DATA/servlet/SetExaminer.html"];
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@",[appDelegate.ipAddress stringByAppendingString:@"FinalReport"]];
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
    NSLog(@"设置检验员界面加载完成");
    self.listData = [NSJSONSerialization JSONObjectWithData:_datas options:NSJSONReadingAllowFragments error:nil];
    [self.tableView reloadData];
    //NSLog(@"%lu",(unsigned long)self.listData.count);
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
    SetExaminerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetOperatorCell" forIndexPath:indexPath];
    
    NSMutableDictionary*  dict = self.listData[indexPath.row];
    cell.bottleDetectNumberLabel.text = [dict objectForKey:@"bottleDetectNumber"];
    cell.bottleNumberLabel.text = [dict objectForKey:@"bottleNumber"];
    cell.carNumberLabel.text = [dict objectForKey:@"carNumber"];
    cell.finalDetectResultLabel.text = [dict objectForKey:@"finalDetectResult"];
    if ([cell.finalDetectResultLabel.text isEqualToString:@"合格"]) {
        cell.finalDetectResultLabel.textColor = [UIColor greenColor];
    } else if ([cell.finalDetectResultLabel.text isEqualToString:@"判废"]){
        cell.finalDetectResultLabel.textColor = [UIColor redColor];
    }
    cell.reportExaminerLabel.text = [dict objectForKey:@"reportExaminer"];
    cell.reportExaminerLabel.textColor = [UIColor colorWithRed:10.0/255.0 green:96.0/255.0 blue:254.0/255.0 alpha:1.0];
    cell.reportCheckerLabel.text = [dict objectForKey:@"reportChecker"];
    cell.reportCheckerLabel.textColor = [UIColor colorWithRed:10.0/255.0 green:96.0/255.0 blue:254.0/255.0 alpha:1.0];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"executeSetOperatorSegue"]) {
        ExecuteSetOperatorViewController *executeSetOperatorViewController = segue.destinationViewController;
        NSInteger row = [[self.tableView indexPathForSelectedRow] row];
        //NSLog(@"%ld",(long)row);
        executeSetOperatorViewController.sendParameters = self.listData[row];
    }
}

@end
