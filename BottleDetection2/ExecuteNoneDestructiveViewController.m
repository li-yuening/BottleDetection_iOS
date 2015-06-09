//
//  ExecuteNoneDestructiveViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/7.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "ExecuteNoneDestructiveViewController.h"
#import "AppDelegate.h"
#import "NSString+URLEncoding.h"

@implementation ExecuteNoneDestructiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bottleDetectNumberLabel.text = [self.sendParameters objectForKey:@"bottleDetectNumber"];
    self.bottleNumberLabel.text = [self.sendParameters objectForKey:@"bottleNumber"];
    self.carNumberLabel.text = [self.sendParameters objectForKey:@"carNumber"];
}

- (IBAction)keyboardHide:(id)sender {
    [sender resignFirstResponder];
}

- (void)startNDRequest{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //NSString *strURL = [[NSString alloc] initWithFormat:@"file:///Volumes/DATA/servlet/AllBottle.html"];
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@",[appDelegate.ipAddress stringByAppendingString:@"ExecuteNoneDestructiveDetection"]];
    
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    //NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSUInteger noneDestructiveResult;
    
    if (self.noneDestructiveResultSegment.selectedSegmentIndex == 0) {
        noneDestructiveResult = 1;
    }else if (self.noneDestructiveResultSegment.selectedSegmentIndex == 1) {
        noneDestructiveResult = 0;
    }
    
    //very complicated to put an integer in dict, so convert it to string
    NSString *noneDestructiveResultString = [NSString stringWithFormat:@"%lu",(unsigned long)noneDestructiveResult];
    
    NSString *noneDestructivePosition = self.noneDestructivePosition.text;
    
    NSString *noneDestructiveDetail = [NSString stringWithFormat:@"%@##%@##%@##%@##%@##",self.flawNumber.text,self.flawType.text,self.flawSize.text,self.finalRating.text,self.detail.text];
    
    //data in dict
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[self.sendParameters objectForKey:@"bottleDetectNumber"],@"bottleDetectNumber",appDelegate.operatorName,@"operatorName",noneDestructivePosition,@"noneDestructivePosition",noneDestructiveDetail,@"noneDestructiveDetail",noneDestructiveResultString,@"noneDestructiveResult",nil];
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
    //NSLog(@"%@",jsonString);
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

- (IBAction)saveNDResult:(id)sender {
    [self startNDRequest];
}

@end
