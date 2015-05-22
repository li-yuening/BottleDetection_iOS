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
}
@property (nonatomic, retain) NSString  *ipAddress;
@property (strong, nonatomic) UIWindow *window;


@end

