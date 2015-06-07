//
//  executeWaterTestPressureViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/5.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "ExecuteWaterTestPressureViewController.h"
#import "AppDelegate.h"
#import "NSString+URLEncoding.h"

@implementation ExecuteWaterTestPressureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bottleDetectNumberLabel.text = [self.sendParameters objectForKey:@"bottleDetectNumber"];
    self.bottleNumberLabel.text = [self.sendParameters objectForKey:@"bottleNumber"];
    self.carNumberLabel.text = [self.sendParameters objectForKey:@"carNumber"];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    //NSLog(@"%ld",(long)row);
    if ((row == 0)&&(section == 1)) {
        self.waterTrueCell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.waterFalseCell.accessoryType = UITableViewCellAccessoryNone;
    }else if ((row == 1)&&(section = 1)) {
        self.waterTrueCell.accessoryType = UITableViewCellAccessoryNone;
        self.waterFalseCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (IBAction)saveWaterResult:(id)sender {
    if ((self.waterTrueCell.accessoryType == UITableViewCellAccessoryNone)&&(self.waterFalseCell.accessoryType == UITableViewCellAccessoryNone)) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"未选择检测结果！" message:@"请选择" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertView show];
    } else {
        [self startSaveWaterRequest];
        self.saveWaterButton.enabled = NO;
    }
}

- (void)startSaveWaterRequest{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //NSString *strURL = [[NSString alloc] initWithFormat:@"file:///Volumes/DATA/servlet/ChubuPanduan.html"];
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@",[appDelegate.ipAddress stringByAppendingString:@"ExecuteWaterTest"]];
    
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    //NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSUInteger waterResult;
    
    if (self.waterTrueCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        waterResult = 1;
    }else if (self.waterFalseCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        waterResult = 0;
    }
    
    //very complicated to put an integer in dict, so convert it to string
    NSString *waterResultString = [NSString stringWithFormat:@"%lu",(unsigned long)waterResult];
    
    //data in dict
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[self.sendParameters objectForKey:@"bottleDetectNumber"],@"bottleDetectNumber",appDelegate.operatorName,@"operatorName",waterResultString,@"waterTestResult",nil];
    NSError *error;
    
    //dict data to json NSData
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:0
                                                         error:&error];
    
    //NSData to string
    NSString *jsonString;
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    //set http post parameter, which is content
    NSString *post = [NSString stringWithFormat:@"content=%@",jsonString];
    
    //string to NSData
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    
    //set http
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
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
    NSLog(@"操作结果返回完成");
    //to do
    [self.navigationController popViewControllerAnimated:YES];
}

@end
