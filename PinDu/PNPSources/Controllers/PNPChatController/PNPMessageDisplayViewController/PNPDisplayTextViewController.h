//
//  PNPDisplayTextViewController.h
//  PinDu
//
//  Created by lianhai on 14-9-24.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNPMessageProtocol.h"

@interface PNPDisplayTextViewController : UIViewController

@property (nonatomic, strong) id <PNPMessageProtocol> message;

@end
