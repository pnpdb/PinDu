//
//  PNPIndexPagerItem.h
//  PinDu
//
//  Created by lianhai on 14-9-28.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNPIndexPagerItem : NSObject

@property (nonatomic, retain)  NSString     *title;
@property (nonatomic, retain)  UIImage      *image;
@property (nonatomic, assign)  NSInteger     tag;

- (id)initWithTitle:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag;

@end
