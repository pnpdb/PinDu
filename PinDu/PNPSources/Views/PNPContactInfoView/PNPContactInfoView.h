//
//  PNPContactInfoView.h
//  PinDu
//
//  Created by lianhai on 14-9-22.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNPContactInfo.h"

@protocol PNPContactInfoAvatorProtocol <NSObject>

/**
 *  定义头像点击事件触发的函数
 */
@optional
- (void)didClickAvator;

@end

@interface PNPContactInfoView : UIView

@property(nonatomic, assign) id<PNPContactInfoAvatorProtocol> delegate;

@property(nonatomic, strong) PNPContactInfo *displayContact;

@end
