//
//  AddBottleViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/2.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "AddBottleViewController.h"
#import "AppDelegate.h"
#import "NSString+URLEncoding.h"
//#import "ReceiveBottleViewController.h"

@interface AddBottleViewController ()

@end

@implementation AddBottleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
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

- (IBAction)saveAddBottle:(id)sender {
    if ([self checkInput]==YES) {
        self.saveBottleButton.enabled = NO;
        [self sendAddBottleRequest];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"有必填项未填写！" message:@"请完成输入" delegate:nil cancelButtonTitle:@"马上写" otherButtonTitles: nil];
        [alertView show];
    }
}

- (Boolean)checkInput {
    Boolean result = YES;
    if (([self.bottleNumberLabel.text isEqualToString:@""])||([self.carNumberLabel.text isEqualToString:@""])||([self.bottleMadeCompanyLabel.text isEqualToString:@""])||([self.bottleNominalPressureLabel.text isEqualToString:@""])||([self.bottleWaterTestPressureLabel.text isEqualToString:@""])||([self.bottleDesignThicknessLabel.text isEqualToString:@""])||([self.bottleActualWeightLabel.text isEqualToString:@""])||([self.bottleActualVolumeLabel.text isEqualToString:@""])||([self.bottleMadeDateLabel.text isEqualToString:@""])||([self.bottleFirstInstallDateLabel.text isEqualToString:@""])||([self.carBelongedCompanyLabel.text isEqualToString:@""])) {
        result = NO;
    }
    return result;
}

//todo
- (IBAction)keyboardHide:(id)sender {
    [sender resignFirstResponder];
}

- (void)sendAddBottleRequest {
    //NSString *strURL = [[NSString alloc] initWithFormat:@"file:///Volumes/DATA/servlet/Login.html"];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@",[appDelegate.ipAddress stringByAppendingString:@"AddBottle"]];
    
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    //NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    //data in dict
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.bottleNumberLabel.text forKey:@"bottleNumber"];
    [dict setValue:self.carNumberLabel.text forKey:@"carNumber"];
    [dict setValue:self.rfidNumberLabel.text forKey:@"rfidNumber"];
    [dict setValue:self.bottleMadeCountryLabel.text forKey:@"bottleMadeCountry"];
    int bottleType = [self checkBottleType];
    [dict setValue:[NSNumber numberWithInt:bottleType] forKey:@"bottleType"];
    NSString *bottleTypeC = [self toStringBottleType];
    [dict setValue:bottleTypeC forKey:@"bottleTypeC"];
    [dict setValue:self.bottleMadeCompanyLabel.text forKey:@"bottleMadeCompany"];
    [dict setValue:self.bottleMadeCompanyIDLabel.text forKey:@"bottleMadeCompanyID"];
    [dict setValue:self.bottleMadeLicenseLabel.text forKey:@"bottleMadeLicense"];
    [dict setValue:self.bottleNominalPressureLabel.text forKey:@"bottleNominalPressure"];
    [dict setValue:self.bottleWaterTestPressureLabel.text forKey:@"bottleWaterTestPressure"];
    [dict setValue:self.bottleDesignThicknessLabel.text forKey:@"bottleDesignThickness"];
    [dict setValue:self.bottleActualWeightLabel.text forKey:@"bottleActualWeight"];
    [dict setValue:self.bottleActualVolumeLabel.text forKey:@"bottleActualVolume"];
    [dict setValue:self.bottleMadeDateLabel.text forKey:@"bottleMadeDate"];
    [dict setValue:self.bottleFirstInstallDateLabel.text forKey:@"bottleFirstInstallDate"];
    [dict setValue:self.bottleLastCheckDateLabel.text forKey:@"bottleLastCheckDate"];
    if ([self.bottleNextCheckDateLabel.text isEqualToString:@""]) {
        self.bottleNextCheckDateLabel.text = @"------";
    }
    [dict setValue:self.bottleNextCheckDateLabel.text forKey:@"bottleNextCheckDate"];
    [dict setValue:self.bottleServiceYearsLabel.text forKey:@"bottleServiceYears"];
    [dict setValue:self.bottleBelongedLabel.text forKey:@"bottleBelonged"];
    [dict setValue:NULL forKey:@"saveDate"];
    [dict setValue:@0 forKey:@"hasDeleted"];
    [dict setValue:self.bottleLicenseLabel.text forKey:@"bottleLicense"];
    [dict setValue:self.bottleGuideLabel.text forKey:@"bottleGuige"]; //should be guige, not guide
    [dict setValue:self.bottleInstallLabel.text forKey:@"bottleInstall"];
    [dict setValue:self.bottleStdVolLabel.text forKey:@"bottleStdVol"];
    [dict setValue:NULL forKey:@"carInfoID"];
    int carType = [self checkCarType];
    [dict setValue:[NSNumber numberWithInt:carType] forKey:@"carType"];
    [dict setValue:self.carTypeLabel.text forKey:@"carTypeC"];
    [dict setValue:self.carBelongedNameLabel.text forKey:@"carBelongedName"];
    [dict setValue:self.carMadeFactoryLabel.text forKey:@"carMadeFactory"];
    [dict setValue:self.carBelongedTelLabel.text forKey:@"carBelongedTel"];
    [dict setValue:self.carBelongedCompanyAddressLabel.text forKey:@"carBelongedCompanyAddress"];
    [dict setValue:self.carBelongedCompanyLabel.text forKey:@"carBelongedCompany"];
    
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
    NSLog(@"添加气瓶结果返回完成");
    self.listData = [NSJSONSerialization JSONObjectWithData:_datas options:NSJSONReadingAllowFragments error:nil];
    
    NSString *isAddBottleSuccess= [self.listData objectForKey:@"isOperationSuccess"];
    if ([isAddBottleSuccess isEqualToString:@"true"]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if ([isAddBottleSuccess isEqualToString:@"false"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"添加失败！" message:@"后台添加气瓶功能异常,请联系管理员" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertView show];
    }
}

- (int)checkBottleType {
    int bottleType;
    if (self.bottleTypeSegment.selectedSegmentIndex == 0) {
        bottleType = 0;
    }else if (self.bottleTypeSegment.selectedSegmentIndex ==1) {
        bottleType = 1;
    }
    return bottleType;
}

- (NSString *)toStringBottleType {
    NSString *bottleType;
    if (self.bottleTypeSegment.selectedSegmentIndex == 0) {
        bottleType = @"钢瓶";
    }else if (self.bottleTypeSegment.selectedSegmentIndex ==1) {
        bottleType = @"缠绕瓶";
    }
    return bottleType;
}

- (int)checkCarType {
    int carType;
    if ([self.carTypeLabel.text isEqualToString:@"特种车"]) {
        carType = 0;
    }else if ([self.carTypeLabel.text isEqualToString:@"公交车"]) {
        carType = 1;
    }else if ([self.carTypeLabel.text isEqualToString:@"环卫车"]) {
        carType = 2;
    }else if ([self.carTypeLabel.text isEqualToString:@"出租车"]) {
        carType = 3;
    }else if ([self.carTypeLabel.text isEqualToString:@"货车"]) {
        carType = 4;
    }else if ([self.carTypeLabel.text isEqualToString:@"私家车"]) {
        carType = 5;
    }else if ([self.carTypeLabel.text isEqualToString:@"公务车"]) {
        carType = 6;
    }else {
        carType = 7;
    }
    return carType;
}

@end
