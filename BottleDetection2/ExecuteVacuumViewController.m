//
//  ExecuteVacuumViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/7.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "ExecuteVacuumViewController.h"
#import "MXPullDownMenu.h"
#import "AppDelegate.h"
#import "NSString+URLEncoding.h"

@implementation ExecuteVacuumViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.bottleDetectNumberLabel.text = [self.sendParameters objectForKey:@"bottleDetectNumber"];
    self.bottleNumberLabel.text = [self.sendParameters objectForKey:@"bottleNumber"];
    self.carNumberLabel.text = [self.sendParameters objectForKey:@"carNumber"];
    self.saveVacuumButton.enabled = NO;
    
    NSArray *testArray;
    testArray = @[@[@"选择检验有效期",@"1",@"2",@"3",@"4",@"5",@"6"]];
    
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:[UIColor colorWithRed:10.0/255.0 green:96.0/255.0 blue:254.0/255.0 alpha:1.0]];
    menu.delegate = self;
    menu.frame = CGRectMake(0, 284, menu.frame.size.width, menu.frame.size.height);
    [self.view addSubview:menu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    if ([self.vacuumPressureTextField.text isEqualToString:@""]) {
        self.vacuumPressureTextField.text = @"-0.09";
    }
    if ((section == 1)&&(row == 3)) {
        if (self.vacuumOverCell.accessoryType == UITableViewCellAccessoryNone) {
            self.vacuumOverCell.accessoryType = UITableViewCellAccessoryCheckmark;
            if (self.validTime != 0) {
                self.saveVacuumButton.enabled = YES;
            }
        } else if (self.vacuumOverCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            self.vacuumOverCell.accessoryType = UITableViewCellAccessoryNone;
            self.saveVacuumButton.enabled = NO;
        }
    }
}

// 实现代理.
#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    if ((column == 0)&&(row == 0)) {
        self.validTime = 0;
    }else if ((column == 0)&&(row == 1)) {
        self.validTime = 1;
    }else if ((column == 0)&&(row == 2)) {
        self.validTime = 2;
    }else if ((column == 0)&&(row == 3)) {
        self.validTime = 3;
    }else if ((column == 0)&&(row == 4)) {
        self.validTime = 4;
    }else if ((column == 0)&&(row == 5)) {
        self.validTime = 5;
    }else if ((column == 0)&&(row == 6)) {
        self.validTime = 6;
    }
    self.nextCheckDateLabel.text = [self makeDate:self.validTime];
    
    if ((self.validTime != 0)&&(self.vacuumOverCell.accessoryType == UITableViewCellAccessoryCheckmark)) {
        self.saveVacuumButton.enabled = YES;
    }
}

- (NSString *)makeDate:(NSInteger)validTime {
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSUInteger year = [dateComponent year];
    NSString *yearString = [NSString stringWithFormat:@"%u",year+validTime];
    NSInteger month = [dateComponent month];
    NSString *monthString = [NSString stringWithFormat:@"%ld",(long)month];
    if (month < 10) {
        monthString = [@"0" stringByAppendingString:monthString];
    }
    NSInteger day = [dateComponent day];
    NSString *dayString = [NSString stringWithFormat:@"%ld",(long)day];
    if (day < 10) {
        dayString = [@"0" stringByAppendingString:dayString];
    }
    NSString *nextCheckDate = [NSString stringWithFormat:@"%@-%@-%@",yearString,monthString,dayString];
    return nextCheckDate;
}

- (void)startSaveRequest{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //NSString *strURL = [[NSString alloc] initWithFormat:@"file:///Volumes/DATA/servlet/ChubuPanduan.html"];
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@",[appDelegate.ipAddress stringByAppendingString:@"ExecuteVacuum"]];
    
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    //NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    //data in dict
    NSString *validTimeString = [NSString stringWithFormat:@"%d",self.validTime];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[self.sendParameters objectForKey:@"bottleDetectNumber"],@"bottleDetectNumber",appDelegate.operatorName,@"operatorName",self.vacuumPressureTextField.text,@"vacuumPressure",@"1",@"vacuumResult",validTimeString,@"yrs",nil];
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
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请求失败，无法保存！" message:@"请查看网络连接或联系管理员" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alertView show];
    NSLog(@"%@",[error localizedDescription]);
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
    NSLog(@"操作结果返回完成");
    //to do
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveVacuumResult:(id)sender {
    if (self.validTime == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"未选择检验有效期，无法保存！" message:@"请选择" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertView show];
    }else {
        [self startSaveRequest];
    }
}

- (IBAction)keyboardHide:(id)sender {
    [sender resignFirstResponder];
}

@end
