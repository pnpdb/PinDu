//
//  PNPPinDuPagerFrame.h
//  PinDu
//
//  Created by lianhai on 14-9-28.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PNPIndexPagerItem;
@class PNPIndexPagerFrame;

@protocol PNPIndexPagerFrameDelegate <NSObject>

- (void)foucusImageFrame:(PNPIndexPagerFrame *)imageFrame didSelectItem:(PNPIndexPagerItem *)item;

@end


@interface PNPIndexPagerFrame : UIView <UIGestureRecognizerDelegate, UIScrollViewDelegate>

- (id)initWithFrame:(CGRect)frame delegate:(id<PNPIndexPagerFrameDelegate>)delegate focusImageItems:(PNPIndexPagerItem *)items, ... NS_REQUIRES_NIL_TERMINATION;

@property (nonatomic, assign) id<PNPIndexPagerFrameDelegate> delegate;

-(void)clickPageImage:(UIButton *)sender;

@end
