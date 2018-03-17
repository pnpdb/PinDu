//
//  PNPSocketPool.h
//  PinDu
//
//  Created by lianhai on 14-9-26.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNPConnModel.h"

@interface PNPConnPool : NSObject

+(void) putConnection:(PNPConnModel*) connection;

+(PNPConnModel*) getConnection:(NSString*) index;

+(void) close:(NSString*) index;

+(void) close;

@end
