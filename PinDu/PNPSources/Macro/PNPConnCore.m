//
//  PNPNetCore.m
//  PinDu
//
//  Created by lianhai on 14-9-25.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPConnCore.h"
#import "CostomUIKit.h"
#import "PNPConnModel.h"
#import "PNPConnPool.h"
#import "PNPMessageHelper.h"

@implementation PNPConnCore

@synthesize mSocket;

-(id) initWithHost:(NSString*) host andPort:(UInt16) port
{
    if(self == [super init]){
        mSocket = [[AsyncSocket alloc] initWithDelegate:self];
        NSError *error = nil;
        if(![mSocket connectToHost:host onPort:port error:&error]){
            NSLog(@"AsyncSocket----connect error");
        }
    }
    
    return  self;
}

-(void)writeData:(NSData *)data
{
    [self.mSocket writeData:data withTimeout:-1 tag:0];
}

#pragma AsyncSocket Delegate
//连接成功
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"AsyncSocket____didConnectToHost");
    PNPConnModel *conn = [[PNPConnModel alloc] initWithIndex:KEY_SERVER_TAG andCore:self];
    [PNPConnPool putConnection:conn];
    //启动数据接收线程
    [sock readDataWithTimeout:-1 tag:0];
}
//连接超时
- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    NSLog(@"AsyncSocket____Client Will Disconnected");
}

-(void)onSocketDidDisconnect:(AsyncSocket*)sock
{
    NSLog(@"AsyncSocket____Client Disconnected: %@:%hu", [sock connectedHost], [sock connectedPort]);
    
//    [CostomUIKit hidmpb];
//    [CostomUIKit mbpSuccess:@"网络连接错误"];
}
//接收数据
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"AsyncSocket____didReadData");
    NSData *strData = [data subdataWithRange:NSMakeRange(0, [data length])];
    
    NSString *tempStr = [[NSString alloc] initWithBytes:[strData bytes] length:[strData length] encoding:NSUTF8StringEncoding];
    NSString *msg = [tempStr substringToIndex:[tempStr length] - 1];
    
    if(msg){
        NSLog(@"AsyncSocket_Recieve:%@",msg);
//        NSString *rr = [msg stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSDictionary *dictionary = [PNPMessageHelper getDictionaryData:msg];
//        NSLog(@"%@", dictionary);
        [self messageDispatcher:dictionary];
    }else{
        NSLog(@"Error converting received data into UTF-8 String");
    }
    [sock readDataWithTimeout:-1 tag:0];
}

-(void) messageDispatcher:(NSDictionary*) dictionary
{
    NSString *Name = [[dictionary objectForKey:@"Command"] objectForKey:@"Name"];
    NSString *Caption = [[dictionary objectForKey:@"Command"] objectForKey:@"Caption"];
    
    if([Name isEqualToString:@"Login"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginNotification" object:dictionary];
    }else if([Name isEqualToString:@"Users"] && [Caption isEqualToString:@"Reg"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RegistNotification" object:dictionary];
    }
    
}

//关闭连接
-(void) close
{
    [mSocket disconnect];
}

@end
