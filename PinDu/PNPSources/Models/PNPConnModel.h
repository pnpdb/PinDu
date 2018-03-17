//
//  PNPConnModel.h
//  PinDu
//
//  Created by lianhai on 14-9-26.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNPConnCore.h"

@interface PNPConnModel : NSObject

@property(nonatomic, copy) NSString *connIndex;

@property(nonatomic, strong) PNPConnCore *connCore;

-(id) initWithIndex:(NSString*) index andCore:(PNPConnCore*) core;

@end
