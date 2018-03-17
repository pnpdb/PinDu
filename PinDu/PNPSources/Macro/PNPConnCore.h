//
//  PNPNetCore.h
//  PinDu
//
//  Created by lianhai on 14-9-25.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"

@interface PNPConnCore : NSObject <AsyncSocketDelegate>

@property(nonatomic, strong) AsyncSocket *mSocket;

-(id) initWithHost:(NSString*) host andPort:(UInt16) port;

-(void)writeData:(NSData *) data;

-(void) close;

@end
