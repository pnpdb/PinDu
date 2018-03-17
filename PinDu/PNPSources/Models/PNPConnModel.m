//
//  PNPConnModel.m
//  PinDu
//
//  Created by lianhai on 14-9-26.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPConnModel.h"

@implementation PNPConnModel

-(id) initWithIndex:(NSString*) index andCore:(PNPConnCore*) core
{
    if(self == [super init]){
        _connIndex = index;
        _connCore = core;
    }
    
    return self;
}

@end
