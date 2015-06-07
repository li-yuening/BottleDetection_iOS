//
//  ExecuteWhorlChangeViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/7.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "ExecuteWhorlChangeViewController.h"
#import "MXPullDownMenu.h"
#import "AppDelegate.h"
#import "NSString+URLEncoding.h"

@implementation ExecuteWhorlChangeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.bottleDetectNumberLabel.text = [self.sendParameters objectForKey:@"bottleDetectNumber"];
    self.bottleNumberLabel.text = [self.sendParameters objectForKey:@"bottleNumber"];
    self.carNumberLabel.text = [self.sendParameters objectForKey:@"carNumber"];
    self.saveBVCButton.enabled = NO;
    
    NSArray *testArray;
    testArray = @[@[@"选择瓶阀型号",@"QS1", @"QS2", @"QS3"],@[@"选择检测结果",@"合格",@"更换"]];
    
    
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:[UIColor colorWithRed:10.0/255.0 green:96.0/255.0 blue:254.0/255.0 alpha:1.0]];
    menu.delegate = self;
    menu.frame = CGRectMake(0, 285, menu.frame.size.width, menu.frame.size.height);
    [self.view addSubview:menu];
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
    //NSLog(@"%ld -- %ld", (long)column, (long)row);
    if ((column == 0)&&(row == 1)) {
        self.bottleValveType = @"QT01";
        self.testPressureLabel.text = @"40";
        self.testMediumLabel.text = @"空气";
        self.saveBVCButton.enabled = YES;
    }else if ((column == 0)&&(row == 2)) {
        self.bottleValveType = @"QT02";
        self.testPressureLabel.text = @"30";
        self.testMediumLabel.text = @"空气";
        self.saveBVCButton.enabled = YES;
    }else if ((column == 0)&&(row == 3)) {
        self.bottleValveType = @"QT03";
        self.testPressureLabel.text = @"20";
        self.testMediumLabel.text = @"空气";
        self.saveBVCButton.enabled = YES;
    }
    
    if ((column == 1)&&(row == 1)) {
        self.bottleValveChangeResult = @"合格";
    } else if ((column == 1)&&(row == 2)) {
        self.bottleValveChangeResult = @"更换";
    }
}

- (IBAction)saveBVCResult:(id)sender {
    if ([self.valveNumberLabel.text isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"未填写瓶阀编号，无法保存！" message:@"请填写" delegate:nil cancelButtonTitle:@"马上写" otherButtonTitles: nil];
        [alertView show];
    }else if ((self.bottleValveType == NULL)||(self.bottleValveChangeResult == NULL)) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"未选择瓶阀类型或检验结果，无法保存！" message:@"请选择" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertView show];
    }else {
        [self startSaveRequest];
    }
}

- (void)startSaveRequest{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //NSString *strURL = [[NSString alloc] initWithFormat:@"file:///Volumes/DATA/servlet/ChubuPanduan.html"];
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@",[appDelegate.ipAddress stringByAppendingString:@"ExecuteBottleValveChange"]];
    
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    //NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    //data in dict
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[self.sendParameters objectForKey:@"bottleDetectNumber"],@"bottleDetectNumber",appDelegate.operatorName,@"operatorName",self.valveNumberLabel.text,@"bottleValveTestNo",self.bottleValveType,@"bottleValveType",self.testPressureLabel.text,@"bottleValveTestPressure",self.testMediumLabel.text,@"bottleValveTestMedium",self.bottleValveChangeResult,@"bottleValveChangeResult",nil];
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

@end
