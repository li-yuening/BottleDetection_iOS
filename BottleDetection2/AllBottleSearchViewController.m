//
//  AllBottleSearchViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/2.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "AllBottleSearchViewController.h"
#import "AllBottleCustomCell.h"
#import "NSString+URLEncoding.h"

@interface AllBottleSearchViewController ()

@end

@implementation AllBottleSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self startRequest];
    
    //register notification, trigger method reloadView()
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(reloadView:)
//                                                 name:@"reloadViewNotification"
//                                               object:nil];
    
    //get local json object
//    NSString* path = [[NSBundle mainBundle] pathForResource:@"Notes" ofType:@"json"];
//    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
//    
//    NSError *error;
//    
//    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                 options:NSJSONReadingMutableContainers error:&error];
//
//    self.listData = jsonObj;
}

- (void)startRequest {
    //http://192.168.1.109:8080/BottleDetection2/servlet/AllBottle?page=1
    //file:///Volumes/DATA/AllBottle.html
    NSString *strURL = [[NSString alloc] initWithFormat:@"file:///Volumes/DATA/AllBottle.html"];
    
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (connection) {
        _datas = [NSMutableData new];
    }
    
    
    //send request and get response json from servlet
    /*NSData *data  = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSLog(@"请求完成...");
    
    //data to json, then serialize json to Array
    self.listData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    [self.tableView reloadData];
    //[self reloadView:resDict];*/
}

#pragma mark- NSURLConnection 回调方法
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_datas appendData:data];
}


-(void) connection:(NSURLConnection *)connection didFailWithError: (NSError *)error {
    
    NSLog(@"%@",[error localizedDescription]);
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
    NSLog(@"请求完成...");
    self.listData = [NSJSONSerialization JSONObjectWithData:_datas options:NSJSONReadingAllowFragments error:nil];
    [self.tableView reloadData];
}

//don't know how it works
/*-(void)reloadView:(NSDictionary *)res
{
    self.listData = [res objectForKey:@"weatherinfo"];
    [self.tableView reloadData];
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.listData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AllBottleCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllBottle" forIndexPath:indexPath];
    
    // Configure the cell...
    //NSUInteger row = [indexPath row];
    NSMutableDictionary*  dict = self.listData[indexPath.row];
    cell.bottleNumberLabel.text = [dict objectForKey:@"BottleNumber"];
    cell.carNumberLabel.text = [dict objectForKey:@"CarNumber"];
    NSUInteger bt = [[dict objectForKey:@"BottleType"] intValue];
    if (bt==0) {
        cell.bottleTypeLabel.text = @"缠绕瓶";
    }
    else if (bt==1) {
        cell.bottleTypeLabel.text = @"钢瓶";
    }
    
    cell.bottleMadeCompanyLabel.text = [dict objectForKey:@"BottleMadeCompany"];
    return cell;
}


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

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 88.0f;
//}

@end
