//
//  ExecuteSetOperatorViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/7.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "ExecuteSetOperatorViewController.h"
#import "AppDelegate.h"
#import "NSString+URLEncoding.h"
#import "MXPullDownMenu.h"

@implementation ExecuteSetOperatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bottleDetectNumberLabel.text = [self.sendParameters objectForKey:@"bottleDetectNumber"];
    self.bottleNumberLabel.text = [self.sendParameters objectForKey:@"bottleNumber"];
    self.carNumberLabel.text = [self.sendParameters objectForKey:@"carNumber"];
    self.finalDetectDateLabel.text = [self.sendParameters objectForKey:@"finalDetectDate"];
    self.finalDetectResultLabel.text = [self.sendParameters objectForKey:@"finalDetectResult"];
    self.nextCheckDateLabel.text = [self.sendParameters objectForKey:@"bottleNextCheckDate"];
    self.reportExaminer = [self.sendParameters objectForKey:@"reportExaminer"];
    self.reportChecker = [self.sendParameters objectForKey:@"reportChecker"];
    self.saveSEButton.enabled = NO;
    
    NSArray *testArray;
    testArray = @[@[@"选择报告检验员",@"冯攀",@"管理员",@"郭展飞",@"虎翼",@"李越宁",@"肖仕明",@"熊涛",@"阴昊",@"郑茂",@"周嘉楠"],@[@"选择报告编制员",@"冯攀",@"管理员",@"郭展飞",@"虎翼",@"李越宁",@"肖仕明",@"熊涛",@"阴昊",@"郑茂",@"周嘉楠"]];
    
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:[UIColor colorWithRed:10.0/255.0 green:96.0/255.0 blue:254.0/255.0 alpha:1.0]];
    menu.delegate = self;
    menu.frame = CGRectMake(0, 60, menu.frame.size.width, menu.frame.size.height);
    [self.view addSubview:menu];
}

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    if (column == 0) {
        if (row == 0) {
            self.reportExaminer = @"";
        } else if (row == 1) {
            self.reportExaminer = @"冯攀";
        } else if (row == 2) {
            self.reportExaminer = @"管理员";
        } else if (row == 3) {
            self.reportExaminer = @"郭展飞";
        } else if (row == 4) {
            self.reportExaminer = @"虎翼";
        } else if (row == 5) {
            self.reportExaminer = @"李越宁";
        } else if (row == 6) {
            self.reportExaminer = @"肖仕明";
        } else if (row == 7) {
            self.reportExaminer = @"熊涛";
        } else if (row == 8) {
            self.reportExaminer = @"阴昊";
        } else if (row == 9) {
            self.reportExaminer = @"郑茂";
        } else if (row == 10) {
            self.reportExaminer = @"周嘉楠";
        }
    } else if (column == 1) {
        if (row == 0) {
            self.reportChecker = @"";
        } else if (row == 1) {
            self.reportChecker = @"冯攀";
        } else if (row == 2) {
            self.reportChecker = @"管理员";
        } else if (row == 3) {
            self.reportChecker = @"郭展飞";
        } else if (row == 4) {
            self.reportChecker = @"虎翼";
        } else if (row == 5) {
            self.reportChecker = @"李越宁";
        } else if (row == 6) {
            self.reportChecker = @"肖仕明";
        } else if (row == 7) {
            self.reportChecker = @"熊涛";
        } else if (row == 8) {
            self.reportChecker = @"阴昊";
        } else if (row == 9) {
            self.reportChecker = @"郑茂";
        } else if (row == 10) {
            self.reportChecker = @"周嘉楠";
        }
    }
    
    if ((self.reportExaminer != NULL)&&(self.reportChecker != NULL)) {
        self.saveSEButton.enabled = YES;
    }
}

- (void)startSaveSetExaminerRequest{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //NSString *strURL = [[NSString alloc] initWithFormat:@"file:///Volumes/DATA/servlet/ChubuPanduan.html"];
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@",[appDelegate.ipAddress stringByAppendingString:@"ExecuteReportExaminerSetting"]];
    
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    //NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    //data in dict
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[self.sendParameters objectForKey:@"bottleDetectNumber"],@"bottleDetectNumber",self.reportExaminer,@"reportExaminer",self.reportChecker,@"reportChecker",nil];
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

- (IBAction)saveSetExaminerResult:(id)sender {
    if (([self.reportExaminer isEqualToString:@""])||([self.reportChecker isEqualToString:@""])) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"未选择报告检验员或编制员，无法保存！" message:@"请选择" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertView show];
    } else {
        [self startSaveSetExaminerRequest];

    }
}
@end
