//
//  ExcuteChubuPanduanController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/22.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "ExecuteChubuPanduanController.h"
#import "NSString+URLEncoding.h"
#import "AppDelegate.h"

@interface ExecuteChubuPanduanController()

@end

@implementation ExecuteChubuPanduanController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.bottleNumberLabel.text = [self.sendParameters objectForKey:@"bottleNumber"];
    self.carNumberLabel.text = [self.sendParameters objectForKey:@"carNumber"];
    if ([[self.sendParameters objectForKey:@"bottleType"] intValue] == 0) {
        self.bottleTypeLabel.text = @"钢瓶";
    }else if ([[self.sendParameters objectForKey:@"bottleType"] intValue] == 1) {
        self.bottleTypeLabel.text = @"缠绕瓶";
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    //NSLog(@"%ld",(long)row);
    if ((row == 0)&&(section == 1)) {
        self.cpTrueCell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.cpFalseCell.accessoryType = UITableViewCellAccessoryNone;
    }else if ((row == 1)&&(section = 1)) {
        self.cpTrueCell.accessoryType = UITableViewCellAccessoryNone;
        self.cpFalseCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (IBAction)saveCP:(id)sender {
    if ((self.cpTrueCell.accessoryType == UITableViewCellAccessoryNone)&&(self.cpFalseCell.accessoryType == UITableViewCellAccessoryNone)) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"未选择检测结果！" message:@"请选择" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertView show];
    } else {
        [self startSaveCPRequest];
    self.saveCPButton.enabled = NO;
    }
}

- (void)startSaveCPRequest{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //NSString *strURL = [[NSString alloc] initWithFormat:@"file:///Volumes/DATA/servlet/ChubuPanduan.html"];
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@",[appDelegate.ipAddress stringByAppendingString:@"ExecuteChubuPanduan"]];
    
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    //NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSUInteger cpresult;
    
    if (self.cpTrueCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cpresult = 1;
    }else if (self.cpFalseCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cpresult = 0;
    }
    
    //can't put integer in dict, so convert it to string
    NSString *cpResultString = [NSString stringWithFormat:@"%lu",(unsigned long)cpresult];
    
    //data in dict
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[self.sendParameters objectForKey:@"bottleNumber"],@"bottleNumber",[self.sendParameters objectForKey:@"bottleType"],@"bottleType",[self.sendParameters objectForKey:@"carNumber"],@"carNumber",cpResultString,@"preDetectResult",nil];
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
    NSLog(@"气瓶流水号返回完成");
    self.listData = [NSJSONSerialization JSONObjectWithData:_datas options:NSJSONReadingAllowFragments error:nil];
    self.bottleDetectNumberLabel.text = [self.listData objectForKey:@"bottleDetectNumber"];
    self.rptNoLabel.text = [self.listData objectForKey:@"rptNo"];
    [self.tableView reloadData];
}

@end
