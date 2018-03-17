//
//  PNPMessageVoiceFactory.h
//  PinDu
//
//  Created by lianhai on 14-9-24.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PNPMessageBubbleFactory.h"

@interface PNPMessageVoiceFactory : NSObject

+ (UIImageView *)messageVoiceAnimationImageViewWithBubbleMessageType:(PNPBubbleMessageType)type;

@end
