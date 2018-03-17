//
//  PNPData.h
//  PinDu
//
//  Created by lianhai on 14-9-25.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNPGlobalData : NSObject

//读取UserDefaults的布尔值
+(BOOL) getDefaultsBOOLValueByKey:(NSString*) key;

+(void) setDefaultBOOLValueForKey:(BOOL) value forKey: key;

//读取UserDefaults的字符串值
+(NSString*) getDefaultsStringValueByKey:(NSString*) key;


@end
