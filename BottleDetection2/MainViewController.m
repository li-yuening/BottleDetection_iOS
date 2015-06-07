//
//  MainViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/2.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.navigationItem.title = @"当前操作员：";
    self.navigationItem.title = [self.navigationItem.title stringByAppendingString:appDelegate.operatorName];
    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self checkRights];
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.toolbarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkRights {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if ([[appDelegate.operatorRights substringWithRange:NSMakeRange(10, 1)] isEqualToString:@"0"]) {
        self.BottleReceiveCell.hidden = YES;
    }
    if ([[appDelegate.operatorRights substringWithRange:NSMakeRange(11, 1)] isEqualToString:@"0"]) {
        self.GlobalDetectionCell.hidden = YES;
    }
    if ([[appDelegate.operatorRights substringWithRange:NSMakeRange(12, 1)] isEqualToString:@"0"]) {
        self.WaterTestPressureCell.hidden = YES;
    }
    if ([[appDelegate.operatorRights substringWithRange:NSMakeRange(13, 1)] isEqualToString:@"0"]) {
        self.InnerDryCell.hidden = YES;
    }
    if ([[appDelegate.operatorRights substringWithRange:NSMakeRange(14, 1)] isEqualToString:@"0"]) {
        self.AirProofTestCell.hidden = YES;
    }
    if ([[appDelegate.operatorRights substringWithRange:NSMakeRange(15, 1)] isEqualToString:@"0"]) {
        self.NoneFunctionCell.hidden = YES;
    }
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
 }
 */

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


- (IBAction)logOut:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
