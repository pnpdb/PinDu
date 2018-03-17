//
//  PNPPrograssKit.h
//  品度
//
//  Created by lianhai on 14-9-10.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CostomUIKit : NSObject

+ (void)hidmpb;

+ (void)mbpSuccess:(NSString *)message;
+ (void)mbpFailed:(NSString *)message;
+(void)showPrograss;
@end
