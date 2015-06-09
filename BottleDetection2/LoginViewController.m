//
//  LoginViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/12.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "NSString+URLEncoding.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationController.toolbarHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    self.tableView.scrollEnabled = NO;
    
    self.operatorPwd.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}*/

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logIn:(id)sender {
    //NSLog(@"haha");
    if ([self nullCheck] == YES) {
        [self startRequest];
    }
}

- (BOOL)nullCheck {
    BOOL result = true;
    if ([self.operatorNumber.text isEqualToString:@""]) {
        result = false;
    }else if ([self.operatorPwd.text isEqualToString:@""]) {
        result = false;
    }
    if (result == false) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败！" message:@"用户名或密码未填写" delegate:nil cancelButtonTitle:@"马上写" otherButtonTitles: nil];
        [alertView show];
    }
    return result;
}

- (void)startRequest {
    //post method
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //NSString *strURL = [[NSString alloc] initWithFormat:@"file:///Volumes/DATA/servlet/Login.html"];
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@",[appDelegate.ipAddress stringByAppendingString:@"Login"]];
    
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    //NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    //data in dict
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.operatorNumber.text forKey:@"operatorNumber"];
    [dict setValue:self.operatorPwd.text forKey:@"operatorPwd"];
    
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
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"连接超时！" message:@"请检查ip输入是否正确并检查网络是否连接" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alertView show];
    NSLog(@"%@",[error localizedDescription]);
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
    NSLog(@"登录结果返回完成");
    self.listData = [NSJSONSerialization JSONObjectWithData:_datas options:NSJSONReadingAllowFragments error:nil];
    
    NSString *isLoginSuccess= [self.listData objectForKey:@"isLoginSuccess"];
    if ([isLoginSuccess isEqualToString:@"true"]) {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        NSDictionary *operatorInfo = [self.listData objectForKey:@"OperatorInfo"];
        appDelegate.operatorName = [operatorInfo objectForKey:@"operatorName"];
        appDelegate.operatorRights = [operatorInfo objectForKey:@"operatorRights"];
        
        [self performSegueWithIdentifier:@"LogIn" sender:self];
    } else if ([isLoginSuccess isEqualToString:@"false"]) {
        self.operatorPwd.text = @"";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败！" message:@"用户名密码错误或用户不存在,请重新输入" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertView show];
    }
}


- (IBAction)keyboardHide:(id)sender {
    
    //operatorPwd get focused
    [self.operatorPwd becomeFirstResponder];
}

@end
