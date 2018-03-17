//
//  PNPIndexPagerItem.m
//  PinDu
//
//  Created by lianhai on 14-9-28.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPIndexPagerItem.h"

@implementation PNPIndexPagerItem

@synthesize title, image, tag;

- (id)initWithTitle:(NSString *)_title image:(UIImage *)_image tag:(NSInteger)_tag
{
    self = [super init];
    if (self) {
        self.title = _title;
        self.image = _image;
        self.tag = _tag;
    }
    
    return self;
}


- (void)dealloc
{
    self.title = nil;
    self.image = nil;
}

@end
