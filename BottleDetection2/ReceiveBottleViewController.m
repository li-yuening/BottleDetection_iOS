//
//  ReceiveBottleViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/6.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "ReceiveBottleViewController.h"
#import "AllBottleCustomCell.h"
#import "NSString+URLEncoding.h"
#import "ExcuteChubuPanduanController.h"

@interface ReceiveBottleViewController ()

@end

@implementation ReceiveBottleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [self startRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
// Dispose of any resources that can be recreated.
}

- (void)startRequest {
    //file:///Volumes/DATA/servlet/ChubuPanduan.html
    NSString *strURL = [[NSString alloc] initWithFormat:@"file:///Volumes/DATA/servlet/ChubuPanduan.html"];
    
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
    NSLog(@"气瓶接收界面加载完成");
    self.listData = [NSJSONSerialization JSONObjectWithData:_datas options:NSJSONReadingAllowFragments error:nil];
    [self.tableView reloadData];
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
    AllBottleCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReceiveBottle" forIndexPath:indexPath];
    
    NSMutableDictionary*  dict = self.listData[indexPath.row];
    cell.bottleNumberLabel.text = [dict objectForKey:@"bottleNumber"];
    cell.carNumberLabel.text = [dict objectForKey:@"carNumber"];
    NSUInteger bt = [[dict objectForKey:@"bottleType"] intValue];
    if (bt==0) {
        cell.bottleTypeLabel.text = @"缠绕瓶";
    }
    else if (bt==1) {
        cell.bottleTypeLabel.text = @"钢瓶";
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
    if ([segue.identifier isEqualToString:@"excuteCPSegue"]) {
        ExcuteChubuPanduanController *excuteChubuPanduanController = segue.destinationViewController;
        NSInteger row = [[self.tableView indexPathForSelectedRow] row];
        //NSLog(@"%ld",(long)row);
        excuteChubuPanduanController.sendParameters = self.listData[row];
    }
}

@end
