//
//  PNPMessageBubbleFactory.h
//  PinDu
//
//  Created by lianhai on 14-9-24.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  标示消息的收发
 */
typedef NS_ENUM(NSInteger, PNPBubbleMessageType) {
    PNPBubbleMessageTypeSending = 0,
    PNPBubbleMessageTypeReceiving
};
/**
 *  Bubble风格(用户设置扩展)
 */
typedef NS_ENUM(NSUInteger, PNPBubbleImageViewStyle) {
    PNPBubbleImageViewStyleWeChat = 0
};

/**
 *  消息类型
 */
typedef NS_ENUM(NSInteger, PNPBubbleMessageMediaType) {
    PNPBubbleMessageMediaTypeText = 0,
    PNPBubbleMessageMediaTypePhoto = 1,
    PNPBubbleMessageMediaTypeVideo = 2,
    PNPBubbleMessageMediaTypeVoice = 3,
    PNPBubbleMessageMediaTypeGIFAnimation = 4,
    PNPBubbleMessageMediaTypeLocalPosition = 5,
};

/**
 *  消息系统菜单
 */
typedef NS_ENUM(NSInteger, PNPBubbleMessageMenuSelecteType) {
    PNPBubbleMessageMenuSelecteTypeTextCopy = 0,
    PNPBubbleMessageMenuSelecteTypeTextTranspond = 1,
    PNPBubbleMessageMenuSelecteTypeTextFavorites = 2,
    PNPBubbleMessageMenuSelecteTypeTextMore = 3,
    
    PNPBubbleMessageMenuSelecteTypePhotoCopy = 4,
    PNPBubbleMessageMenuSelecteTypePhotoTranspond = 5,
    PNPBubbleMessageMenuSelecteTypePhotoFavorites = 6,
    PNPBubbleMessageMenuSelecteTypePhotoMore = 7,
    
    PNPBubbleMessageMenuSelecteTypeVideoTranspond = 8,
    PNPBubbleMessageMenuSelecteTypeVideoFavorites = 9,
    PNPBubbleMessageMenuSelecteTypeVideoMore = 10,
    
    PNPBubbleMessageMenuSelecteTypeVoicePlay = 11,
    PNPBubbleMessageMenuSelecteTypeVoiceFavorites = 12,
    PNPBubbleMessageMenuSelecteTypeVoiceTurnToText = 13,
    PNPBubbleMessageMenuSelecteTypeVoiceMore = 14,
};

@interface PNPMessageBubbleFactory : NSObject

+ (UIImage *)bubbleImageViewForType:(PNPBubbleMessageType)type
                              style:(PNPBubbleImageViewStyle)style
                          meidaType:(PNPBubbleMessageMediaType)mediaType;

@end
