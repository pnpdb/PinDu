//
//  PNPMacro.h
//  PinDu
//
//  Created by lianhai on 14-9-19.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#ifndef PinDu_PNPMacro_h
#define PinDu_PNPMacro_h

// 朋友圈分享的图片以及图片之间的间隔
#define kPNPAlbumPhotoSize 40
#define kPNPAlbumPhotoInsets 5

// Max record Time
#define kVoiceRecorderTotalTime 60.0

// device verson float value
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

// iPad
#define kIsiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// image STRETCH
#define XH_STRETCH_IMAGE(image, edgeInsets) (CURRENT_SYS_VERSION < 6.0 ? [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] : [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])

#endif
