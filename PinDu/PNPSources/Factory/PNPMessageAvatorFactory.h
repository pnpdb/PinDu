//
//  PNPMessageAvatorFactory.h
//  PinDu
//
//  Created by lianhai on 14-9-24.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>

// 头像大小以及头像与其他控件的距离
static CGFloat const kPNPAvatarImageSize = 40.0f;
static CGFloat const kPNPAlbumAvatorSpacing = 15.0f;

typedef NS_ENUM(NSInteger, PNPMessageAvatorType) {
    PNPMessageAvatorTypeNormal = 0,
    PNPMessageAvatorTypeSquare,
    PNPMessageAvatorTypeCircle
};

@interface PNPMessageAvatorFactory : NSObject

+ (UIImage *)avatarImageNamed:(UIImage *)originImage
            messageAvatorType:(PNPMessageAvatorType)type;

@end
