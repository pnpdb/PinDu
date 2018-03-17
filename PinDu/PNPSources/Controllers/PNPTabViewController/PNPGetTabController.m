//
//  PNPGetTabController.m
//  PinDu
//
//  Created by lianhai on 14-9-19.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPGetTabController.h"
#import "PNPPinDuViewController.h"
#import "PNPSessionViewController.h"
#import "PNPContactViewController.h"
#import "PNPDiscoveryViewController.h"
#import "PNPNavigationViewController.h"

@implementation PNPGetTabController

+(PNPTabBarViewController*) getInstance
{
    PNPPinDuViewController *pinduTabViewController = [[PNPPinDuViewController alloc] init];
    pinduTabViewController.title = @"品度";
    pinduTabViewController.tabBarItem.image = [UIImage imageNamed:@"Tab_Index"];
    PNPNavigationViewController *pinduNavigationController = [[PNPNavigationViewController alloc] initWithRootViewController:pinduTabViewController];
    
    PNPSessionViewController *sessionTabViewController = [[PNPSessionViewController alloc] init];
    sessionTabViewController.title = @"会话";
    sessionTabViewController.tabBarItem.image = [UIImage imageNamed:@"Tab_Session"];
    PNPNavigationViewController *sessionNavigationController = [[PNPNavigationViewController alloc] initWithRootViewController:sessionTabViewController];
    
    PNPContactViewController *contactTabViewController = [[PNPContactViewController alloc] init];
    contactTabViewController.title = @"联系人";
    contactTabViewController.tabBarItem.image = [UIImage imageNamed:@"Tab_Contact"];
    PNPNavigationViewController *contactNavigationController = [[PNPNavigationViewController alloc] initWithRootViewController:contactTabViewController];
    
    PNPDiscoveryViewController *discoveryViewController = [[PNPDiscoveryViewController alloc] init];
    discoveryViewController.title = @"发现";
    discoveryViewController.tabBarItem.image = [UIImage imageNamed:@"Tab_Discovery"];
    PNPNavigationViewController *discoveryNavigationController = [[PNPNavigationViewController alloc] initWithRootViewController:discoveryViewController];
    
    PNPTabBarViewController *rootTabBarController = [[PNPTabBarViewController alloc] init];
    rootTabBarController.viewControllers = [NSArray arrayWithObjects:pinduNavigationController, sessionNavigationController, contactNavigationController, discoveryNavigationController, nil];
    
    [rootTabBarController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarBkg"]];
    
    return rootTabBarController;
}

@end
