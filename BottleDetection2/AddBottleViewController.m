//
//  AddBottleViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/2.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "AddBottleViewController.h"
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
        //[self sendAddBottelRequst];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"有必填项未填写！" message:@"请完成输入" delegate:nil cancelButtonTitle:@"马上写" otherButtonTitles: nil];
        [alertView show];
    }
}

- (Boolean)checkInput {
    Boolean result = YES;
    if (([self.bottleNumberLabel.text isEqualToString:@""])||([self.carNumberLabel.text isEqualToString:@""])||([self.bottleMadeCompanyLabel.text isEqualToString:@""])||([self.bottleNominalPressureLabel.text isEqualToString:@""])||([self.bottleWaterTestPressureLabel.text isEqualToString:@""])||([self.bottleDesignThicknessLabel.text isEqualToString:@""])||([self.bottleActualWeightLabel.text isEqualToString:@""])||([self.bottleActualVolumeLabel.text isEqualToString:@""])||([self.bottleMadeDateLabel.text isEqualToString:@""])||([self.bottleFirstInstallDateLabel.text isEqualToString:@""])) {
        result = NO;
    }
    return result;
}

//to be implemented
- (IBAction)keyboardHide:(id)sender {
    
    //operatorPwd get focused
    if (sender==self.bottleNumberLabel) {
        [self.carNumberLabel becomeFirstResponder];
    }
    else if (sender==self.carNumberLabel) {
        [self.bottleMadeCountryLabel becomeFirstResponder];
    }
}
@end
