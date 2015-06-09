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
#import "AppDelegate.h"
#import "AllBottleDetailViewController.h"

@interface AllBottleSearchViewController ()

@end

@implementation AllBottleSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFirstLoad = self.isFirstLoad + 1;
    self.pagePresent = 1;
    self.previousPageButton.enabled = false;
    self.nextPageButton.enabled = false;
    if (self.isFirstLoad == 1) {
        [self startRequest];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}

- (IBAction)previousPage:(id)sender {
    self.pagePresent = self.pagePresent - 1;
    [self startRequest];
}

- (IBAction)nextPage:(id)sender {
    self.pagePresent = self.pagePresent + 1;
    [self startRequest];
}

- (void)startRequest {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //NSString *strURL = [[NSString alloc] initWithFormat:@"file:///Volumes/DATA/servlet/AllBottle.html"];
    NSString *pageString = [[NSString alloc]initWithFormat:@"%@",[NSString stringWithFormat:@"%lu",(unsigned long)self.pagePresent]];
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@%@",[appDelegate.ipAddress stringByAppendingString:@"AllBottle?page="],pageString];
    NSLog(@"%@",strURL);
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
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
    NSLog(@"返回所有气瓶完成");
    self.previousPageButton.enabled = YES;
    self.nextPageButton.enabled = YES;
    self.listDataDict = [NSJSONSerialization JSONObjectWithData:_datas options:NSJSONReadingAllowFragments error:nil];
    self.listData = [self.listDataDict objectForKey:@"content"];
    NSUInteger pageInTable = [[self.listDataDict objectForKey:@"pageInTable"] intValue];
    if (self.pagePresent <= 1) {
        self.previousPageButton.enabled = false;
        self.nextPageButton.enabled = true;
    }
    if (self.pagePresent >= pageInTable) {
        self.nextPageButton.enabled = false;
        self.previousPageButton.enabled = true;
    }
    NSString *navigationTitle = [[NSString alloc]initWithFormat:@"%@ / %@",[NSString stringWithFormat:@"%lu",(unsigned long)self.pagePresent],[self.listDataDict objectForKey:@"pageInTable"]];
    self.navigationItem.title = navigationTitle;
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
    cell.bottleNumberLabel.text = [dict objectForKey:@"bottleNumber"];
    cell.carNumberLabel.text = [dict objectForKey:@"carNumber"];
    NSUInteger bt = [[dict objectForKey:@"bottleType"] intValue];
    if (bt==0) {
        cell.bottleTypeLabel.text = @"钢瓶";
    }
    else if (bt==1) {
        cell.bottleTypeLabel.text = @"缠绕瓶";
    }
    
    cell.bottleMadeCompanyLabel.text = [dict objectForKey:@"bottleMadeCompany"];
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"allBottleDetailSegue"]) {
        AllBottleDetailViewController *allBottleDetailViewController = segue.destinationViewController;
        NSInteger row = [[self.tableView indexPathForSelectedRow] row];
        //NSLog(@"%ld",(long)row);
        allBottleDetailViewController.sendParameters = self.listData[row];
    }
}

@end
