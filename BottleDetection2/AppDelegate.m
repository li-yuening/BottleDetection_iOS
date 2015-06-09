//
//  AppDelegate.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/2.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize ipAddress;
@synthesize operatorName;
@synthesize operatorRights;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //self.ipAddress = @"http://192.168.1.109:8080/BottleDetection2/servlet/";
    self.ipAddress = [self getIPAddress];
    //NSLog(@"读取文件 %@",self.ipAddress);
    return YES;
}

- (NSString *)getIPAddress {
    NSString *ipAddressString;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"IPAddress.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断是否存在IPAddress.plist
    if (![fileManager fileExistsAtPath:plistPath]) {
        //NSLog(@"bucunzai");
        NSMutableDictionary *dictplist = [[NSMutableDictionary alloc ] init];
        //设置属性值
        [dictplist setObject:@"http://192.168.1.109:8080/BottleDetection2/servlet/" forKey:@"ipAddress"];
        //写入文件
        [dictplist writeToFile:plistPath atomically:YES];
    } else {
        NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        ipAddressString = [data objectForKey:@"ipAddress"];
    }
    return ipAddressString;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
