//
//  PNPPrograssKit.m
//  品度
//
//  Created by lianhai on 14-9-10.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "CostomUIKit.h"
#import "MBProgressHUD.h"
#import "PNPAppDelegate.h"

static MBProgressHUD *eHUD = nil;

@implementation CostomUIKit

+ (void)mbpSuccess:(NSString *)message
{
    PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
    eHUD = [MBProgressHUD HUDForView:appDelegate.window];
    if (eHUD) {
        if([[eHUD class] isSubclassOfClass:[MBProgressHUD class]] )//&& eHUD.detailsLabelText)
        {
            if([eHUD.detailsLabelText isEqualToString:message])
            {
                return;
            }
        }
        [self hidmpb];
    }
    eHUD = [MBProgressHUD showHUDAddedTo:appDelegate.window animated:YES];
    //eHUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
    eHUD.userInteractionEnabled = NO;
    eHUD.mode = MBProgressHUDModeText;
    eHUD.detailsLabelText = message;
    [self performSelector:@selector(hidmpb) withObject:nil afterDelay:3];//2
}

+ (void)mbpFailed:(NSString *)message
{
    PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
    eHUD = [MBProgressHUD HUDForView:appDelegate.window];
    if (eHUD) {
        [self hidmpb];
    }
    eHUD = [MBProgressHUD showHUDAddedTo:appDelegate.window animated:YES];
    eHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-False.png"]];
    eHUD.mode = MBProgressHUDModeCustomView;
    eHUD.labelText = message;
    [self performSelector:@selector(hidmpb) withObject:nil afterDelay:1];
}

+(void)showPrograss
{
    PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
    eHUD = [MBProgressHUD HUDForView:appDelegate.window];
    if (eHUD) {
        [self hidmpb];
    }
    eHUD = [MBProgressHUD showHUDAddedTo:appDelegate.window animated:YES];
    eHUD.mode = MBProgressHUDModeIndeterminate;
    eHUD.dimBackground = YES;
    
    eHUD.labelText = @"加载中";
}

+ (void)hidmpb
{
    PNPAppDelegate *appDelegate = (PNPAppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD hideHUDForView:appDelegate.window animated:YES];
    appDelegate.window.userInteractionEnabled=YES;
}

@end
