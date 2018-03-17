//
//  PNPSocketPool.m
//  PinDu
//
//  Created by lianhai on 14-9-26.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPConnPool.h"

@implementation PNPConnPool

static NSMutableArray* connPool;

+(void) putConnection:(PNPConnModel*) connection
{
    if(!connPool)
        connPool= [[NSMutableArray alloc] initWithCapacity:10];
    
    for (PNPConnModel *conn in connPool) {
        if([conn.connIndex isEqualToString:connection.connIndex]){
            [conn.connCore close];
            [connPool removeObject:conn];
        }
    }
    NSLog(@"向连接池中添加一个连接");
    [connPool addObject:connection];
}

+(PNPConnModel*) getConnection:(NSString*) index
{
    if(!connPool)
        connPool= [[NSMutableArray alloc] initWithCapacity:10];
    
    for(PNPConnModel *conn in connPool){
        if([conn.connIndex isEqualToString:index]){
            NSLog(@"从连接池取出一个连接");
            return conn;
        }
    }
    
    return nil;
}

+(void) close:(NSString*) index
{
    if(!connPool)
        return ;
    
    for(PNPConnModel *conn in connPool){
        if([conn.connIndex isEqualToString:index]){
            [conn.connCore close];
            [connPool removeObject:conn];
        }
    }
}

+(void) close
{
    if(connPool){
        for(PNPConnModel *conn in connPool){
            [conn.connCore close];
        }
        [connPool removeAllObjects];
    }
    
    
}

@end
