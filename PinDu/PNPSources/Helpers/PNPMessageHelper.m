//
//  PNPMessageHelper.m
//  PinDu
//
//  Created by lianhai on 14-9-26.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPMessageHelper.h"

@implementation PNPMessageHelper

+(NSData*) getMessageData:(PNPCommand*) command
{
    GDataXMLElement *rootElement = [GDataXMLNode elementWithName:@"Command"];
    
    GDataXMLNode *guidNode = [GDataXMLNode attributeWithName:@"Guid" stringValue:command.Guid];
    GDataXMLNode *nameNode = [GDataXMLNode attributeWithName:@"Name" stringValue:command.Name];
    GDataXMLNode *captionNode = [GDataXMLNode attributeWithName:@"Caption" stringValue:command.Caption];
    GDataXMLNode *routeNode = [GDataXMLNode attributeWithName:@"Route" stringValue:command.Route];
    GDataXMLNode *commandNode = [GDataXMLNode attributeWithName:@"Command" stringValue:command.Command];
    GDataXMLNode *userNode = [GDataXMLNode attributeWithName:@"User" stringValue:command.User];
    GDataXMLNode *fromNode = [GDataXMLNode attributeWithName:@"From" stringValue:command.From];
    GDataXMLNode *tagNode = [GDataXMLNode attributeWithName:@"Tag" stringValue:command.Tag];
    GDataXMLNode *idNode = [GDataXMLNode attributeWithName:@"ID" stringValue:command.ID];
    GDataXMLNode *stateNode = [GDataXMLNode attributeWithName:@"State" stringValue:command.State];
    GDataXMLNode *valueNode = [GDataXMLNode attributeWithName:@"Value" stringValue:command.Value];
    GDataXMLNode *blockNode = [GDataXMLNode attributeWithName:@"Block" stringValue:command.Block];
    GDataXMLNode *objectNode = [GDataXMLNode attributeWithName:@"Object" stringValue:command.Object];
    GDataXMLNode *sourceNode = [GDataXMLNode attributeWithName:@"Source" stringValue:command.Source];
    
    [rootElement addAttribute:guidNode];
    [rootElement addAttribute:nameNode];
    [rootElement addAttribute:captionNode];
    [rootElement addAttribute:routeNode];
    [rootElement addAttribute:commandNode];
    [rootElement addAttribute:userNode];
    [rootElement addAttribute:fromNode];
    [rootElement addAttribute:tagNode];
    [rootElement addAttribute:idNode];
    [rootElement addAttribute:stateNode];
    [rootElement addAttribute:valueNode];
    [rootElement addAttribute:blockNode];
    [rootElement addAttribute:objectNode];
    [rootElement addAttribute:sourceNode];
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithRootElement:rootElement];
    NSData *data =  [document XMLData];
    NSString *content = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    NSString *content2 = [[content substringFromIndex:22] stringByAppendingString:@"\0"];
    
    NSLog(@"---------%@", content2);
    
    NSData* data2 = [content2 dataUsingEncoding:NSASCIIStringEncoding];
    
    
    return data2;
}

+(NSDictionary*) getDictionaryData:(NSString*) message
{
    NSError *error = nil;
    NSData *xmlData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictionary = [XMLReader dictionaryForXMLData:xmlData error:&error];
    
    if(error)
        NSLog(@"XMLReader Error:%@", error);
    
    return dictionary;
    
}

@end
