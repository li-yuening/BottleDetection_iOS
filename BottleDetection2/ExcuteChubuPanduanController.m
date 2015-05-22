//
//  ExcuteChubuPanduanController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/22.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "ExcuteChubuPanduanController.h"
#import "NSString+URLEncoding.h"
#import "AppDelegate.h"

@interface ExcuteChubuPanduanController()

@end

@implementation ExcuteChubuPanduanController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.bottleNumberLabel.text = [self.sendParameters objectForKey:@"bottleNumber"];
    self.carNumberLabel.text = [self.sendParameters objectForKey:@"carNumber"];
    if ([[self.sendParameters objectForKey:@"bottleType"] intValue] == 0) {
        self.bottleTypeLabel.text = @"缠绕瓶";
    }else if ([[self.sendParameters objectForKey:@"bottleType"] intValue] == 1) {
        self.bottleTypeLabel.text = @"钢瓶";
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
    [self startSaveCPRequest];
    self.saveCPButton.enabled = NO;
}

- (void)startSaveCPRequest{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //NSString *strURL = [[NSString alloc] initWithFormat:@"file:///Volumes/DATA/servlet/ChubuPanduan.html"];
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@",[appDelegate.ipAddress stringByAppendingString:@"ExcuteChubuPanduan"]];
    
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    //NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSUInteger cpresult;
    
    if (self.cpTrueCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cpresult = 1;
    }else if (self.cpFalseCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cpresult = 0;
    }
    
    NSString *cpResultString = [NSString stringWithFormat:@"%lu",(unsigned long)cpresult];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"bottleNumber",self.bottleNumberLabel.text,@"preDetectResult",cpResultString,nil];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:0
                                                         error:&error];
//    NSString *jsonString;
//    if (! jsonData) {
//        NSLog(@"Got an error: %@", error);
//    } else {
//        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    }
//    
//    NSString *post = [NSString stringWithFormat:@"content=%@",jsonString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    
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
