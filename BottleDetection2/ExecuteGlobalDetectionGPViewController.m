//
//  ExecuteGlobalDetectionGPViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/24.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "ExecuteGlobalDetectionGPViewController.h"
#import "AppDelegate.h"
#import "NSString+URLEncoding.h"

@implementation ExecuteGlobalDetectionGPViewController

- (IBAction)keyboardHide:(id)sender {
    [sender resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bottleDetectNumberLabel.text = [self.sendParameters objectForKey:@"bottleDetectNumber"];
    self.bottleNumberLabel.text = [self.sendParameters objectForKey:@"bottleNumber"];
    self.carNumberLabel.text = [self.sendParameters objectForKey:@"carNumber"];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    //NSLog(@"%ld",(long)row);
    if ((row == 0)&&(section == 1)) {
        if (self.metalDetectCell.accessoryType == UITableViewCellAccessoryNone) {
            self.metalDetectCell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else if (self.metalDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            self.metalDetectCell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else if ((row == 2)&&(section == 1)) {
        if (self.heatDetectCell.accessoryType == UITableViewCellAccessoryNone) {
            self.heatDetectCell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else if (self.heatDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            self.heatDetectCell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else if ((row == 4)&&(section == 1)) {
        if (self.roundDetectCell.accessoryType == UITableViewCellAccessoryNone) {
            self.roundDetectCell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else if (self.roundDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            self.roundDetectCell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else if ((row == 6)&&(section == 1)) {
        if (self.innerDetectCell.accessoryType == UITableViewCellAccessoryNone) {
            self.innerDetectCell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else if (self.innerDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            self.innerDetectCell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else if ((row == 8)&&(section == 1)) {
        if (self.whorlDetectCell.accessoryType == UITableViewCellAccessoryNone) {
            self.whorlDetectCell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else if (self.whorlDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            self.whorlDetectCell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else if ((row == 10)&&(section == 1)) {
        if (self.soundDetectCell.accessoryType == UITableViewCellAccessoryNone) {
            self.soundDetectCell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else if (self.soundDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            self.soundDetectCell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

- (void)startSaveGDGPRequest{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //NSString *strURL = [[NSString alloc] initWithFormat:@"file:///Volumes/DATA/servlet/ChubuPanduan.html"];
    NSString *strURL = [[NSString alloc] initWithFormat:@"%@",[appDelegate.ipAddress stringByAppendingString:@"ExecuteGlobalDetection"]];
    
    NSURL *url = [NSURL URLWithString:[strURL URLEncodedString]];
    
    //NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSString *detectDetailResult = [self makeDetailString];
    
    //data in dict
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[self.sendParameters objectForKey:@"bottleDetectNumber"],@"bottleDetectNumber",@"0",@"bottleType",appDelegate.operatorName,@"operatorName",detectDetailResult,@"detectDetailResult",self.metalDetectTextField.text,@"appearDetail",self.heatDetectTextField.text,@"soundDetail",self.roundDetectTextField.text,@"whorlDetail",self.innerDetectTextField.text,@"innerDetail",self.whorlDetectTextField.text,@"globalSub5Detail",self.soundDetectTextField.text,@"globalSub6Detail",nil];
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

- (NSString *)makeDetailString {
    if (self.metalDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        self.appearDetail = @"1";
    } else {
        self.appearDetail = @"0";
    }
    if (self.heatDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        self.soundDetail = @"1";
    } else {
        self.soundDetail = @"0";
    }
    if (self.roundDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        self.whorlDetail = @"1";
    } else {
        self.whorlDetail = @"0";
    }
    if (self.innerDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        self.innerDetail = @"1";
    } else {
        self.innerDetail = @"0";
    }
    if (self.whorlDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        self.globalSub5Detail = @"1";
    } else {
        self.globalSub5Detail = @"0";
    }
    if (self.soundDetectCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        self.globalSub6Detail = @"1";
    } else {
        self.globalSub6Detail = @"0";
    }
    NSString *detectDetailString = [NSString stringWithFormat:@"%@%@%@%@%@%@",self.appearDetail,self.soundDetail,self.whorlDetail,self.innerDetail,self.globalSub5Detail,self.globalSub6Detail];
    return detectDetailString;
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

- (IBAction)saveGDGPResult:(id)sender {
    [self startSaveGDGPRequest];
}
@end
