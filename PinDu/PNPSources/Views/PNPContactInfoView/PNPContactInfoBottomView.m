//
//  PNPContactInfoBottomView.m
//  PinDu
//
//  Created by lianhai on 14-9-24.
//  Copyright (c) 2014年 http://pnpdb.com. All rights reserved.
//

#import "PNPContactInfoBottomView.h"
#import "PNPContactInfo.h"

@implementation PNPContactInfoBottomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIButton *)videoBottomButton {
    if (!_videoBottomButton) {
        _videoBottomButton = [[UIButton alloc] initWithFrame:CGRectMake(kPNPAlbumAvatorSpacing, 20, CGRectGetWidth(self.bounds) - kPNPAlbumAvatorSpacing * 2, kPNPContactButtonHeight)];
        _videoBottomButton.layer.cornerRadius = 4;
        _videoBottomButton.backgroundColor = [UIColor colorWithRed:0.263 green:0.717 blue:0.031 alpha:1.000];
        [_videoBottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_videoBottomButton setTitle:@"发消息" forState:UIControlStateNormal];
        [self addSubview:_videoBottomButton];
    }
    return _videoBottomButton;
}

- (UIButton *)messageBottomButton {
    if (!_messageBottomButton) {
        _messageBottomButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.videoBottomButton.frame), CGRectGetMaxY(self.videoBottomButton.frame) + kPNPContactButtonSpacing, CGRectGetWidth(self.videoBottomButton.bounds), CGRectGetHeight(self.videoBottomButton.bounds))];
        _messageBottomButton.layer.cornerRadius = 4;
        _messageBottomButton.backgroundColor = [UIColor colorWithWhite:0.838 alpha:1.000];
        [_messageBottomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_messageBottomButton setTitle:@"视频聊天" forState:UIControlStateNormal];
        [self addSubview:_messageBottomButton];
    }
    return _messageBottomButton;
}

@end
