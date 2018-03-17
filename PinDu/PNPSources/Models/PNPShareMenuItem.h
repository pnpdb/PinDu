//
//  PNPChatMenuItem.h
//  PinDu
//
//  Created by lianhai on 14-9-24.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPNPShareMenuItemWidth 60
#define KPNPShareMenuItemHeight 80

@interface PNPShareMenuItem : NSObject

@property (nonatomic, strong) UIImage *normalIconImage;

@property (nonatomic, copy) NSString *title;

- (instancetype)initWithNormalIconImage:(UIImage *)normalIconImage
                                  title:(NSString *)title;

@end
