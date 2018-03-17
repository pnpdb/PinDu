//
//  PNPCommand.h
//  品度
//
//  Created by lianhai on 14-9-11.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNPCommand : NSObject

@property(nonatomic, copy) NSString* Guid;
@property(nonatomic, copy) NSString* Name;
@property(nonatomic, copy) NSString* Caption;
@property(nonatomic, copy) NSString* Route;
@property(nonatomic, copy) NSString* Command;
@property(nonatomic, copy) NSString* User;
@property(nonatomic, copy) NSString* From;
@property(nonatomic, copy) NSString* Tag;
@property(nonatomic, copy) NSString* ID;
@property(nonatomic, copy) NSString* State;
@property(nonatomic, copy) NSString* Value;
@property(nonatomic, copy) NSString* Block;
@property(nonatomic, copy) NSString* Object;
@property(nonatomic, copy) NSString* Source;
@property(nonatomic, copy) NSString* XML;

@end
