//
//  PNPSessionModel.h
//  PinDu
//
//  Created by lianhai on 14-9-19.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNPSessionModel : NSObject

@property(nonatomic, strong) UIImage *avator;

@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSString *record;

@property(nonatomic, copy) NSString *time;

@property(nonatomic, assign) BOOL failed;

-(id)initWithAvator:(UIImage*)avator Name:(NSString*)name Record:(NSString*)record Time:(NSString*)time Failed:(BOOL) failed;

@end
