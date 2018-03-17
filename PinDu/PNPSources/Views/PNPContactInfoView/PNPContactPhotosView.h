//
//  PNPContactPhotosView.h
//  PinDu
//
//  Created by lianhai on 14-9-22.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNPContactPhotosView : UIView

@property (nonatomic, strong) NSArray *photos;

- (void)reloadData;

@end
