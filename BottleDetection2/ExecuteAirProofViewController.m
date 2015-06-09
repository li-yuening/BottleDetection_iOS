//
//  ExecuteAirProofViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/7.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "ExecuteAirProofViewController.h"
#import "MXPullDownMenu.h"
#import "AppDelegate.h"
#import "NSString+URLEncoding.h"

@implementation ExecuteAirProofViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.bottleDetectNumberLabel.text = [self.sendParameters objectForKey:@"bottleDetectNumber"];
    self.bottleNumberLabel.text = [self.sendParameters objectForKey:@"bottleNumber"];
    self.carNumberLabel.text = [self.sendParameters objectForKey:@"carNumber"];
    
    NSArray *testArray;
    testArray = @[@[@"选择试验方法",@"浸水法"]];
    
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:[UIColor colorWithRed:10.0/255.0 green:96.0/255.0 blue:254.0/255.0 alpha:1.0]];
    menu.delegate = self;
    menu.frame = CGRectMake(0, 240, menu.frame.size.width, menu.frame.size.height);
    [self.view addSubview:menu];
    self.saveAPButton.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 实现代理.
#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    if ((column == 0)&&(row == 0)) {
        self.airProofTestMethod = @"";
    }else if ((column == 0)&&(row == 1)) {
        self.airProofTestMethod = @"浸水法";
        self.testMediumLabel.text = @"空气";
        self.testMediumTempLabel.text = @"9";
        self.testPressureLabel.text = @"20";
        self.testKeepTimeLabel.text = @"2";
    }
    
    if (self.airProofTestMethod != NULL) {
        self.saveAPButton.enabled = YES;
    }
}

- (void)startSaveRequest{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //NSString *strURL = [[NSString alloc] initWithFormat:@"file:///Volumes/DATA/servlet/ChubuPanduan.html"];
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@",[appDelegate.ipAddress stringByAppendingString:@"ExecuteAirProofTest"]];
    
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    //NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSString *airProofTestResult;
    if (self.testResultSegment.selectedSegmentIndex == 0) {
        airProofTestResult = @"1";
    } else if (self.testResultSegment.selectedSegmentIndex == 1) {
        airProofTestResult = @"0";
    }
    
    //data in dict
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[self.sendParameters objectForKey:@"bottleDetectNumber"],@"bottleDetectNumber",appDelegate.operatorName,@"operatorName",self.airProofTestMethod,@"airProofTestMethod",self.testMediumLabel.text,@"airProofTestMedium",self.testMediumTempLabel.text,@"airProofTestTemp",self.testPressureLabel.text,@"airProofTestPressure",self.testKeepTimeLabel.text,@"airProofTestKeepTime",airProofTestResult,@"airProofTestResult",nil];
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

- (IBAction)saveAPResult:(id)sender {
    if ([self.airProofTestMethod isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"未选择试验方法，无法保存！" message:@"请选择" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertView show];
    }else {
        [self startSaveRequest];
    }

}

@end
