//
//  ExecuteWhorlChangeViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/7.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "ExecuteWhorlChangeViewController.h"
#import "MXPullDownMenu.h"

@implementation ExecuteWhorlChangeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.bottleDetectNumberLabel.text = [self.sendParameters objectForKey:@"bottleDetectNumber"];
    self.bottleNumberLabel.text = [self.sendParameters objectForKey:@"bottleNumber"];
    self.carNumberLabel.text = [self.sendParameters objectForKey:@"carNumber"];
        
    
    NSArray *testArray;
    testArray = @[@[@"选择瓶阀型号",@"待检", @"合格", @"判废"],@[@"选择检测结果",@"合格",@"更换"]];
    
    
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
    NSLog(@"%ld -- %ld", (long)column, (long)row);
}


@end
