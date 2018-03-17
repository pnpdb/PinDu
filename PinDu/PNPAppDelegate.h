//
//  PNPAppDelegate.h
//  PinDu
//
//  Created by lianhai on 14-9-19.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface PNPAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) Reachability *hostReach;

@property (nonatomic, assign) BOOL isReachable;

@end
