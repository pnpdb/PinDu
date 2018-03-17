//
//  PNPContactInfo.m
//  PinDu
//
//  Created by lianhai on 14-9-22.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPContactInfo.h"

@implementation PNPContactInfo

- (NSArray *)contactMyAlbums {
    if (!_contactMyAlbums) {
        _contactMyAlbums = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"lianhai"], [UIImage imageNamed:@"haosiyun"], [UIImage imageNamed:@"yanminmin"], nil];
    }
    return _contactMyAlbums;
}

- (NSString *)contactIntroduction {
    if (!_contactIntroduction) {
        _contactIntroduction = @"开始一个人的旅行";
    }
    return _contactIntroduction;
}

-(NSString*) contactNickName
{
    if(!_contactNickName){
        _contactNickName = @"超越自己";
    }
    return _contactNickName;
}

- (NSString *)contactId {
    if (!_contactId) {
        _contactId = @"PNP001";
    }
    return _contactId;
}

-(NSString*) contactName
{
    if(_contactName){
        _contactName = @"李安海";
    }
    return _contactName;
}

- (NSString *)contactRegion {
    if (!_contactRegion) {
        _contactRegion = @"北京市海淀区";
    }
    return _contactRegion;
}

- (NSString *)description {
    return self.contactName;
}

@end
