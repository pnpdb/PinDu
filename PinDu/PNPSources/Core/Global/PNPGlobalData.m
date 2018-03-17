//
//  PNPData.m
//  PinDu
//
//  Created by lianhai on 14-9-25.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPGlobalData.h"

@implementation PNPGlobalData

+(BOOL) getDefaultsBOOLValueByKey:(NSString*) key
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+(void) setDefaultBOOLValueForKey:(BOOL) value forKey: key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:key];
    [defaults synchronize];
    
}

+(NSString*) getDefaultsStringValueByKey:(NSString*) key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
