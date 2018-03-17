//
//  PNPMessageAvatorFactory.m
//  PinDu
//
//  Created by lianhai on 14-9-24.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPMessageAvatorFactory.h"
#import "UIImage+Rounded.h"

@implementation PNPMessageAvatorFactory

+ (UIImage *)avatarImageNamed:(UIImage *)originImage
            messageAvatorType:(PNPMessageAvatorType)messageAvatorType {
    CGFloat radius = 0.0;
    switch (messageAvatorType) {
        case PNPMessageAvatorTypeNormal:
            return originImage;
            break;
        case PNPMessageAvatorTypeCircle:
            radius = originImage.size.width / 2.0;
            break;
        case PNPMessageAvatorTypeSquare:
            radius = 8;
            break;
        default:
            break;
    }
    UIImage *avator = [originImage createRoundedWithRadius:radius];
    return avator;
}

@end
