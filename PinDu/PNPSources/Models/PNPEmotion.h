//
//  PNPEmotion.h
//  PinDu
//
//  Created by lianhai on 14-9-24.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPNPEmotionImageViewSize 60
#define kPNPEmotionMinimumLineSpacing 16

@interface PNPEmotion : NSObject

/**
 *  gif表情的封面图
 */
@property (nonatomic, strong) UIImage *emotionConverPhoto;

/**
 *  gif表情的路径
 */
@property (nonatomic, copy) NSString *emotionPath;

@end
