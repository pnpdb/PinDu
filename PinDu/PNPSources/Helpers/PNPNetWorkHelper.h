//
//  PNPNetWorkHelper.h
//  PinDu
//
//  Created by lianhai on 14-9-27.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNPNetWorkHelper : NSObject

+(BOOL) isNetworkEnabled;

+ (NSString *)replaceUnicode:(NSString *)unicodeStr;

@end
