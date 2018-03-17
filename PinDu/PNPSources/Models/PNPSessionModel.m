//
//  PNPSessionModel.m
//  PinDu
//
//  Created by lianhai on 14-9-19.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPSessionModel.h"

@implementation PNPSessionModel

-(id)initWithAvator:(UIImage*)avator Name:(NSString*)name Record:(NSString*)record Time:(NSString*)time Failed:(BOOL) failed
{
    if(self = [super init]){
        _avator = avator;
        _name = name;
        _record = record;
        _time = time;
        _failed = failed;
    }
    return self;
}

-(void) dealloc
{
    self.avator = nil;
}

@end
