//
//  ExecuteGlobalDetectionCRViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/24.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "ExecuteGlobalDetectionCRViewController.h"
#import "AppDelegate.h"
#import "NSString+URLEncoding.h"

@implementation ExecuteGlobalDetectionCRViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
}

- (IBAction)saveGDCRResult:(id)sender {
    [self startSaveGDCRRequest];
}

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
        if (self.metalDetectCell.accessoryType == UITableViewCellAccessoryNone) {
            self.metalDetectCell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else if (self.metalDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            self.metalDetectCell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else if ((row == 2)&&(section == 1)) {
        if (self.appearDetectCell.accessoryType == UITableViewCellAccessoryNone) {
            self.appearDetectCell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else if (self.appearDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            self.appearDetectCell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else if ((row == 3)&&(section == 1)) {
        if (self.whorlDetectCell.accessoryType == UITableViewCellAccessoryNone) {
            self.whorlDetectCell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else if (self.whorlDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            self.whorlDetectCell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

- (void)startSaveGDCRRequest{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //NSString *strURL = [[NSString alloc] initWithFormat:@"file:///Volumes/DATA/servlet/ChubuPanduan.html"];
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@",[appDelegate.ipAddress stringByAppendingString:@"ExecuteGlobalDetection"]];
    
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    //NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSString *detectDetailResult = [self makeDetailString];
    
    //data in dict
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[self.sendParameters objectForKey:@"bottleDetectNumber"],@"bottleDetectNumber",@"1",@"bottleType",appDelegate.operatorName,@"operatorName",detectDetailResult,@"detectDetailResult",self.metalDetectTextField.text,@"appearDetail",self.whorlDetectTextField.text,@"soundDetail",NULL,@"whorlDetail",NULL,@"innerDetail",NULL,@"globalSub5Detail",NULL,@"globalSub6Detail",nil];
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
    
    NSLog(@"%@",jsonString);
    
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

- (NSString *)makeDetailString {
    if (self.metalDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        self.appearDetail = @"1";
    } else {
        self.appearDetail = @"0";
    }
    if (self.appearDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        self.soundDetail = @"1";
    } else {
        self.soundDetail = @"0";
    }
    if (self.whorlDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        self.whorlDetail = @"1";
    } else {
        self.whorlDetail = @"0";
    }
    NSString *detectDetailString = [NSString stringWithFormat:@"%@%@%@",self.appearDetail,self.soundDetail,self.whorlDetail];
    return detectDetailString;
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
