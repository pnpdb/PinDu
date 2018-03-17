//
//  PNPFileAttribute.m
//  PinDu
//
//  Created by lianhai on 14-9-24.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPFileAttribute.h"

@implementation PNPFileAttribute

- (id)initWithPath:(NSString *)filePath attributes:(NSDictionary *)attributes {
    self = [super init];
    if(self){
        self.filePath = filePath;
        self.fileAttributes = attributes;
    }
    return self;
}

- (NSDate *)fileModificationDate {
    return [_fileAttributes fileModificationDate];
}

- (NSString *)description {
    return self.filePath;
}

@end
