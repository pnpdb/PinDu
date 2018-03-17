//
//  PNPAppDelegate.m
//  PinDu
//
//  Created by lianhai on 14-9-19.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPAppDelegate.h"
#import "PNPGetTabController.h"
#import "PNPLoginViewController.h"
#import "PNPGuideViewController.h"
#import "PNPNavigationViewController.h"
#import "PNPGlobalData.h"
#import "CostomUIKit.h"
#import "PNPMacro.h"

@implementation PNPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NSThread sleepForTimeInterval:2.0];
    [self initNavigationBar];
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"] ;
    //开始监听，会启动一个run loop
    [self.hostReach startNotifier];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIViewController *rootViewController = nil;
    if([PNPGlobalData getDefaultsBOOLValueByKey:KEY_HAD_RUNNED]){
        if([PNPGlobalData getDefaultsStringValueByKey:KEY_USER_ACCOUNT]){
            rootViewController = [PNPGetTabController getInstance];
        }else{
            rootViewController = [[PNPNavigationViewController alloc] initWithRootViewController:[[PNPLoginViewController alloc] initWithNibName:@"LoginView" bundle:nil]];
        }
    }else{
        rootViewController = [[PNPNavigationViewController alloc] initWithRootViewController:[[PNPGuideViewController alloc] init]];
    }
    
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void) initNavigationBar
{
    if (CURRENT_SYS_VERSION >= 7.0) {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.071 green:0.060 blue:0.086 alpha:1.000]];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    } else {
        [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.071 green:0.060 blue:0.086 alpha:1.000]];
    }
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:18], NSFontAttributeName, nil]];
}

-(void)reachabilityChanged:(NSNotification *)note
{
//    Reachability *currReach = [note object];
//    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
//    
//    //对连接改变做出响应处理动作
//    NetworkStatus status = [currReach currentReachabilityStatus];
//    //如果没有连接到网络就弹出提醒实况
//    self.isReachable = YES;
//    if(status == NotReachable){
//        [CostomUIKit mbpSuccess:@"网络连接异常"];
//        
//        self.isReachable = NO;
//        return;
//    }
//    if (status==kReachableViaWiFi||status==kReachableViaWWAN) {
//        
//        [CostomUIKit mbpSuccess:@"网络连接正常"];
//        self.isReachable = YES;
//    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
