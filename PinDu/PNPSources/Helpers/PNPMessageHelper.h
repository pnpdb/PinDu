//
//  PNPMessageHelper.h
//  PinDu
//
//  Created by lianhai on 14-9-26.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#import "PNPCommand.h"
#import "XMLReader.h"

@interface PNPMessageHelper : NSObject

+(NSData*) getMessageData:(PNPCommand*) command;

+(NSDictionary*) getDictionaryData:(NSString*) message;

@end
