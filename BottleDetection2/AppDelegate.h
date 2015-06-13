//
//  AppDelegate.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/2.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSString *ipAddress;
    NSString *operatorNumber;
    NSString *operatorRights;
}
@property (nonatomic, retain) NSString *ipAddress;
@property (nonatomic, retain) NSString *shortIP;
@property (nonatomic, retain) NSString *operatorName;
@property (nonatomic, retain) NSString *operatorRights;
@property (strong, nonatomic) UIWindow *window;
- (NSString *)makeFullIP:(NSString *)ip;

@end

