//
//  PNPContactInfo.h
//  PinDu
//
//  Created by lianhai on 14-9-22.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPNPAlbumAvatorSpacing 15
#define kPNPContactAvatorSize 60
#define kPNPContactNameLabelHeight 30

#define kPNPContactButtonHeight 40
#define kPNPContactButtonSpacing 15

@interface PNPContactInfo : NSObject

@property(nonatomic, assign) BOOL contactIsFemale;

@property(nonatomic, copy) NSString *contactName;

@property(nonatomic, copy) NSString *contactId;

@property(nonatomic,copy) NSString *contactNickName;

@property(nonatomic, copy) NSString *contactRegion;

@property(nonatomic, copy) NSString *contactIntroduction;

@property(nonatomic, copy) NSArray *contactMyAlbums;

@end
